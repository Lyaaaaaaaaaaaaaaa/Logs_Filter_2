#------------------------------------------------------------------------------
#-- Copyright (c) 2021 Lyaaaaaaaaaaaaaaa
#--
#-- Author : Lyaaaaa
#--
#-- Implementation Notes:
#--  -
#-- Changelog:
#--  - 29/04/2021 Lyaaaaa
#--    - Created the file and implemented the signals handlers.
#------------------------------------------------------------------------------
extends PopupDialog


func _on_WebSiteButton_pressed() -> void:
    OS.shell_open("https://github.com/Lyaaaaaaaaaaaaaaa/Logs_Filter_2")


func _on_DiscordButton_pressed():
    OS.shell_open("https://discordapp.com/invite/hSey9Bv")
