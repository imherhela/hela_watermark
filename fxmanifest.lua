-----------------------------------------------------------------
-- Logo Watermark- A Simple FiveM Script, Made By Jordan.#2139 --
--  RedM Watermark- A simple RedM script, Edited by ImHerHela  --
-----------------------------------------------------------------

game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'

-- Define the resource metadata
name "RedM Watermark"
description "A Simple Watermark Script"
author "ImHerHela"
version "v1.2.0"

client_scripts {
	"client.lua",
	'config.lua'
}

ui_page 'html/ui.html'
files {
	'html/*',
	'img/logo.png'
}