fx_version 'cerulean'
game 'gta5'

description 'QB-Fishing'
version '1.0.0'

shared_scripts { 
	'@qb-core/import.lua',
	'config.lua'
}

client_scripts {
	'client/main.lua'
}

server_scripts {
	'server/main.lua'
}