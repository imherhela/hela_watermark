-----------------------------------------------------------------
-- Logo Watermark- A Simple FiveM Script, Made By Jordan.#2139 --
--  hela_watermark- A simple RedM script, Edited by ImHerHela  --
-----------------------------------------------------------------

game 'rdr3'
fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'

-- Define the resource metadata
description "A Simple Watermark Script"
author "ImHerHela"

client_scripts {
	'config.lua',
	'client.lua'
}

ui_page 'html/ui.html'
files {
	'html/*',
	'img/logo.png'
}

dependency {
	'vorp_core'
}

version "1.1.0"
vorp_checker 'yes'
vorp_name '^5Hela_Watermark ^4Version Check^3
vorp_github 'https://github.com/imherhela/hela_watermark'
