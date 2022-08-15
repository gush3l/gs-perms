fx_version 'adamant'
game 'gta5'

author "gush3l"
description "Fast and efficient permissions and groups solution for an actual proper permissions and groups system! Also really easy to implement in your resource."
version '1.0.0'

lua54 'yes'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'main.lua',
    'utils.lua',
    'commands.lua',
    'config.lua',
    'classes/*.lua'
}

dependency 'oxmysql'