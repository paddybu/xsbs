SQLite format 3   @                                                                             �    ��                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        	                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              \  \4t�\�^                                                                      �U�tablebansbansCREATE TABLE bans (
	id INTEGER NOT NULL, 
	ip INTEGER, 
	expiration INTEGER, 
	reason VARCHAR, 
	nick VARCHAR, 
	banner_ip INTEGER, 
	banner_nick VARCHAR, 
	time INTEGER, 
	PRIMARY KEY (id)
)>!Uindexix_bans_ipbansCREATE INDEX ix_bans_ip ON bans (ip)V1uindexix_bans_expirationbansCREATE INDEX ix_bans_expiration ON bans (expiration)�%%�]tablebanned_nicksbanned_nicksCREATE TABLE banned_nicks (
	id INTEGER NOT NULL, 
	nick VARCHAR, 
	reason VARCHAR, 
	PRIMARY KEY (id)
)d5%}indexix_banned_nicks_nickbanned_nicksCREATE INDEX ix_banned_nicks_nick ON banned_nicks (nick)�))�mtableuserprivilegesuserprivilegesCREATE TABLE userprivileges (
	id INTEGER NOT NULL, 
	privilege INTEGER, 
	user_id INTEGER, 
	PRIMARY KEY (id)
)�//�mtableusermanager_usersusermanager_usersCREATE TABLE usermanager_users (
	id INTEGER NOT NULL, 
	email VARCHAR, 
	password VARCHAR, 
	PRIMARY KEY (id)
)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 r r�xh                                                                                                                                                                                                                                                                                                                                                                  |A/�indexix_usermanager_users_emailusermanager_users
CREATE INDEX ix_usermanager_users_email ON usermanager_users (email)�	G/�!indexix_usermanager_users_passwordusermanager_usersCREATE INDEX ix_usermanager_users_password ON usermanager_users (password)�m
==�mtableusermanager_nickaccountsusermanager_nickaccountsCREATE TABLE usermanager_nickaccounts (
	id INTEGER NOT NULL, 
	nick VARCHAR, 
	user_id INTEGER, 
	PRIMARY KEY (id), 
	 FOREIGN KEY(user_id) REFERENCES usermanager_users (id)
)�M=�-indexix_usermanager_nickaccounts_nickusermanager_nickaccountsCREATE INDEX ix_usermanager_nickaccounts_nick ON usermanager_nickaccounts (nick)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  L���h                                                                                                                                                                                                                                                                      J'aindexix_ip_name_ipip_nameCREATE INDEX ix_ip_name_ip ON ip_name (ip)z�Ktableip_nameip_nameCREATE TABLE ip_name (
	id INTEGER NOT NULL, 
	ip INTEGER, 
	nick VARCHAR, 
	PRIMARY KEY (id)
)f7!�indexix_clanmember_user_idclanmemberCREATE INDEX ix_clanmember_user_id ON clanmember (user_id)n�/tableclantagsclantagsCREATE TABLE clantags (
	id INTEGER NOT NULL, 
	tag VARCHAR, 
	PRIMARY KEY (id)
)Q+iindexix_clantags_tagclantagsCREATE INDEX ix_clantags_tag ON clantags (tag)�
!!�_tableclanmemberclanmemberCREATE TABLE clanmember (
	id INTEGER NOT NULL, 
	tag_id INTEGER, 
	user_id INTEGER, 
	PRIMARY KEY (id)
)b5!}indexix_clanmember_tag_idclanmemberCREATE INDEX ix_clanmember_tag_id ON clanmember (tag_id)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              