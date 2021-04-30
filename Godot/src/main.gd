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
#--
#--  - 30/04/2021 Lyaaaaa
#--     - Now count and display the number of matching lines and lines searched
#--     - Added matching_lines and total_lines var
#--     - Updated search_file to increment the line counters and call
#--         display_stats once the search is over
#--     - Added display_stats method to format a string and display it in the
#--         TopMenu
#--     - Added reset_counters method
#--     - Updated _on_ToolBar_start_button_pressed to call reset_counters
#--     - Added _on_ToolBar_switch_case_sensitive_button_pressed signal handler.
#------------------------------------------------------------------------------
extends Control

var parser := Parser.new()
var file   := File.new()

var matching_lines := 0
var total_lines    := 0

func search_file() -> void:
    var line : String

    $Interface/ToolBar.disable_buttons()
    while file.eof_reached() == false:
        total_lines += 1
        line = file.get_line()

        if parser.search_line(line) == true:
            matching_lines += 1
            display_line(line)

    display_stats()
    $Interface/ToolBar.enable_buttons()


func display_stats() -> void:
    var text : String

    text = String(matching_lines) + "/" + String(total_lines) + " matching lines"
    $Interface/TopMenu.set_text_top_right_label(text)


func display_line(p_line : String) -> void:
    $Interface/OutputDisplay.append_text(p_line)


func reset_counters() -> void:
    matching_lines = 0
    total_lines    = 0


func _on_ToolBar_start_button_pressed(p_filters : Array) -> void:
    reset_counters()
    $Interface/OutputDisplay.clear()
    parser.set_filters(p_filters)

    file.seek(0)
    search_file()


func _on_ToolBar_switch_mode_button_pressed() -> void:
    parser.switch_mode()


func _on_ToolBar_switch_case_sensitive_button_pressed() -> void:
    parser.switch_case_sensitivity()


func _on_FileDialog_file_selected(p_path : String) -> void:
    $Interface/ToolBar.enable_buttons()
    $Interface/TopMenu.set_text_top_label(p_path)

    file.open(p_path, File.READ)


func _on_TopMenu_open_file_button_pressed() -> void:
    $Dialogs/FileDialog.popup_centered()


func _on_TopMenu_about_button_pressed() -> void:
    $Dialogs/AboutDialog.popup_centered()
