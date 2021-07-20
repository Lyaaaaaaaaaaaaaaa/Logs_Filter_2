#------------------------------------------------------------------------------
#-- Copyright (c) 2021 Lyaaaaaaaaaaaaaaa
#--
#-- Author : Lyaaaaa
#--
#-- Implementation Notes:
#--  -
#-- Changelog:
#--  - 29/04/2021 Lyaaaaa
#--    - Created the file and implemented it.
#--
#--  - 20/07/2021 Lyaaaaa
#--    - Added the _clipboard_button var.
#--    - Updated append_text and clear to set visible and invisible the new
#--        clipboard button.
#--    - Updated _init_variables to init _clipboard_button.
#--    - Added the _on_ClipboardButton_pressed.
#------------------------------------------------------------------------------
extends Panel

var _rich_label       : RichTextLabel
var _clipboard_button : Button

func _ready() -> void:
    _init_variables()


func append_text(p_text : String) -> void:
    _rich_label.add_text(p_text + "\n")
    _clipboard_button.visible = true

func clear() -> void:
    _rich_label.clear()
    _clipboard_button.visible = false


func _init_variables() -> void:
    _rich_label       = find_node("RichLabel")
    _clipboard_button = find_node("ClipboardButton")

func _on_ClipboardButton_pressed() -> void:
    var Os   := OS
    Os.set_clipboard(_rich_label.text)
