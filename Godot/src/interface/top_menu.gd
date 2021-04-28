#------------------------------------------------------------------------------
#-- Copyright (c) 2021 Lyaaaaaaaaaaaaaaa
#--
#-- Author : Lyaaaaa
#--
#-- Implementation Notes:
#--  -
#-- Changelog:
#--  - 28/04/2021 Lyaaaaa
#--     - Created the file.
#------------------------------------------------------------------------------

extends Panel

signal open_file_button_pressed
signal about_button_pressed

var _file_button : MenuButton
var _help_button : MenuButton

var _file_popup_menu : PopupMenu
var _help_popup_menu : PopupMenu

var _top_label       : Label
var _top_right_label : Label

func _ready() -> void:
    _init_variables()
    _register_handlers()

func set_text_top_label(p_text : String) -> void:
    _top_label.text = p_text

func set_text_top_right_label(p_text : String) -> void:
    _top_right_label.text = p_text

func _init_variables() -> void:
    _file_button  = find_node("FileButton")
    _help_button  = find_node("HelpButton")

    _top_label       = find_node("TopLabel")
    _top_right_label = find_node("TopRightLabel")

    _file_popup_menu = _file_button.get_popup()
    _help_popup_menu = _help_button.get_popup()

func _register_handlers() -> void:
    _file_popup_menu.connect("id_pressed", self, "_on_open_file_popup_menu_pressed")
    _help_popup_menu.connect("id_pressed", self, "_on_help_popup_menu_pressed")

func _on_open_file_popup_menu_pressed(p_id : int) -> void:
    if p_id == 0:
        emit_signal("open_file_button_pressed")

func _on_help_popup_menu_pressed(p_id : int) -> void:
    if p_id == 0:
        emit_signal("about_button_pressed")
