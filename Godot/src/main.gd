#------------------------------------------------------------------------------
#-- Copyright (c) 2021 Lyaaaaaaaaaaaaaaa
#--
#-- Author : Lyaaaaaaaaaaaaaaa
#--
#-- Implementation Notes:
#--  -
#-- Changelog:
#--  - 27/04/2021 Lyaaaaa
#--     - Created the empty file.
#--
#--  - 29/04/2021 Lyaaaaa
#--     - Added the variables parser and file
#--     - Implemented search_file, display_line functions.
#--     - Implemented the following signal handlers
#--       - _on_ToolBar_start_button_pressed,
#--       - _on_ToolBar_switch_mode_button_pressed,
#--       - _on_FileDialog_file_selected,
#--       - _on_TopMenu_open_file_button_pressed,
#--       - _on_TopMenu_about_button_pressed.
#------------------------------------------------------------------------------
extends Control

var parser := Parser.new()
var file   := File.new()


func search_file() -> void:
    var line : String

    $Interface/ToolBar.disable_buttons()
    while file.eof_reached() == false:
        line = file.get_line()

        if parser.search_line(line) == true:
            display_line(line)

    $Interface/ToolBar.enable_buttons()

func display_line(p_line : String) -> void:
    $Interface/OutputDisplay.append_text(p_line)


func _on_ToolBar_start_button_pressed(p_filters : Array) -> void:
    $Interface/OutputDisplay.clear()
    parser.set_filters(p_filters)

    file.seek(0)
    search_file()


func _on_ToolBar_switch_mode_button_pressed() -> void:
    parser.switch_mode()


func _on_FileDialog_file_selected(p_path : String) -> void:
    $Interface/ToolBar.enable_buttons()
    $Interface/TopMenu.set_text_top_label(p_path)

    file.open(p_path, File.READ)


func _on_TopMenu_open_file_button_pressed() -> void:
    $Dialogs/FileDialog.popup_centered()


func _on_TopMenu_about_button_pressed() -> void:
    $Dialogs/AboutDialog.popup_centered()
