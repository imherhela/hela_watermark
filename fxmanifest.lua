-----------------------------------------------------------------
-- Logo Watermark- A Simple FiveM Script, Made By Jordan.#2139 --
--  hela_watermark- A simple RedM script, Edited by ImHerHela  --
-----------------------------------------------------------------

game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'

-- Define the resource metadata
name "hela_watermark"
description "A Simple Watermark Script"
author "ImHerHela"
version "v1.3.0"

client_scripts {
	'config.lua',
	'client.lua'
}

ui_page 'html/ui.html'
files {
	'html/*',
	'img/logo.png'
}
