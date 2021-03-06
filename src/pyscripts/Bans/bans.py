from xsbs.settings import PluginConfig
from xsbs.colors import red, colordict
from xsbs.ui import insufficientPermissions, error, info
from xsbs.db import dbmanager
from xsbs.commands import commandHandler, UsageError, ArgumentValueError
from xsbs.events import triggerServerEvent, eventHandler, policyHandler, execLater
from xsbs.ban import ban, isIpBanned, isNickBanned, Ban
from xsbs.net import ipLongToString, ipStringToLong
from xsbs.players import masterRequired, player
from xsbs.server import message as serverMessage
import time, string
import logging

config = PluginConfig('bans')
ban_command = config.getOption('Config', 'ban_command', 'ban')
default_ban_length = config.getOption('Config', 'default_ban_time', 3600)
default_reason = config.getOption('Config', 'default_reason', 'unspecified reason')
kick_message = config.getOption('Config', 'kick_message', '${green}${name}${white} was ${red}kicked${white} from server')
del config
kick_message = string.Template(kick_message)

session = dbmanager.session()

@commandHandler('ban')
@masterRequired
def onBanCmd(cn, text):
	'''@description Ban user from server
	   @usage <seconds> (reason)'''
	sp = text.split(' ')
	p = player(cn)
	try:
		tcn = int(sp[0])
		ip = p.ipLong()
		reason = ''
		length = 0
		if len(sp) >= 3:
			reason = sp[2]
		else:
			reason = default_reason
		if len(sp) >= 2:
			length = int(sp[1])
		else:
			length = int(default_ban_length)
		ban(tcn, length, reason, cn)
	except (ValueError, KeyError):
		raise UsageError('cn (duration) (reason)')

@commandHandler('recentbans')
@masterRequired
def onRecentBans(cn, args):
	'''@description Recently added bans
	   @usage'''
	p = player(cn)
	if args != '':
		raise UsageError()
	else:
		recent = dbmanager.query(Ban).order_by(Ban.time.desc())[:5]
		for ban in recent:
			p.message(info('Nick: %s' % ban.nick))

@policyHandler('connect_kick')
def allowClient(cn, pwd):
	p = player(cn)
	ip = p.ipLong()
	return not isIpBanned(ip) and not isNickBanned(p.name())

@eventHandler('player_kick')
@masterRequired
def onKick(cn, tcn):
	ban(tcn, 14500, 'Unspecified reason', cn)

@commandHandler('kick')
@masterRequired
def onKickCommand(cn, args):
	'''@description Kick player from the server without ban time
	   @usage <cn>'''
	tcn = int(args)
	t = player(tcn)
	serverMessage(info(kick_message.substitute(colordict, name=p.name())))
	t.kick()

@commandHandler('insertban')
@masterRequired
def onInsertBan(cn, args):
	'''@description Intert ban for ip address
	   @usage <ip> <seconds> (reason)'''
	p = player(cn)
	args = args.split(' ')
	if len(args) < 2:
		raise UsageError('ip length (reason)')
	else:
		ip = ipStringToLong(args[0])
		length = int(args[1])
		try:
			reason = args[2]
		except IndexError:
		 	reason = 'Unspecified reason'
		expiration = time.time() + length
		newban = Ban(ip, expiration, reason, 'Unnamed', 0, 'Unnamed', time.time())
		session.add(newban)
		session.commit()
		p.message(info('Inserted ban for %s for %i seconds for %s.' % (ipLongToString(ip), length, reason)))

@commandHandler('banname')
@masterRequired
def onBanName(cn, args):
	'''@description Ban name from the server
	   @usage <name>'''
	p = player(cn)
	reason = args.split(' ')
	if len(reason) == 1:
		nick = reason[0]
		reason = 'Unspecified reason'
	else:
		nick = reason.pop(0)
		reason = args[len(nick)+1:]
	b = BanNick(nick, reason)
	session.add(b)
	session.commit()
	p.message(info('Inserted nick ban of %s for %s' % (nick, reason)))

def clearBans():
	bans = dbmanager.query(Ban).filter('expiration>'+str(time.time())).all()
	for b in bans:
		session.delete(b)
	session.commit()

@eventHandler('server_clear_bans')
@masterRequired
def reqClearBans(cn):
	clearBans()
	serverMessage(info('Bans cleared'))

@commandHandler('clearbans')
@masterRequired
def onClearBansCmd(cn, args):
	'''@description Remove active bans
	   @usage'''
	clearBans()
	serverMessage(info('Bans cleared'))

gbans = {}

@policyHandler('connect_kick')
def isNotGBanned(cn, pwd):
	p = player(cn)
	try:
		gbans[p.ipString()]
		return False
	except KeyError:
		return True

@eventHandler('master_addgban')
def adGBan(ip_string):
	gbans[ip_string] = True

@eventHandler('master_cleargbans')
def clearGBans():
	gbans.clear()

