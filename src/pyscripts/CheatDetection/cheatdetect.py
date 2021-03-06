from xsbs.events import registerServerEventHandler
from xsbs.players import player, masterRequired
from xsbs.ui import warning, error, info
from xsbs.settings import PluginConfig
from xsbs.commands import registerCommandHandler

config = PluginConfig('cheatdetection')
spectate_map_modified = (config.getOption('Config', 'spectate_map_modified', 'yes') == 'yes')
del config

def onMapModified(cn):
	player(cn).gamevars['modified_map'] = True
	checkModified(cn)

def checkModified(cn):
	try:
		p = player(cn)
		if p.gamevars['modified_map'] and spectate_map_modified:
			p.message(warning('You cannot play with a modified map.'))
			p.spectate()
	except KeyError:
		pass
	except ValueError:
	 	pass

@masterRequired
def mapModifiedSpecCmd(cn, args):
	'''@description Enable or disable spectate clients with modified map
	   @usage enable/disable'''
	p = player(cn)
	if args == 'disable':
		spectate_map_modified = False
		p.message(info('Spectate modified mapes disabled'))
	elif args == 'enable':
		spectate_map_modified = True
		p.message(info('Spectate modified mapes enabled'))
	else:
		p.message(error('Usage: #mapmodifiedspec (enable/disable)'))

registerServerEventHandler('player_modified_map', onMapModified)
registerServerEventHandler('player_active', checkModified)
registerServerEventHandler('player_unspectated', checkModified)
registerCommandHandler('mapmodifiedspec', mapModifiedSpecCmd)

