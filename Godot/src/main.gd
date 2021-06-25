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
#--     - Added var to store the nodes instead of using them with $path/node,
#--         this will prevent errors if the main scene hierarchy is updated.
#--
#--  - 22/06/2021 Lyaaaaa
#--     - Updated display_stats to make the displayed string more explicit.
#------------------------------------------------------------------------------
extends Control

var parser := Parser.new()
var file   := File.new()

var matching_lines := 0
var total_lines    := 0

onready var top_menu       = find_node("TopMenu")
onready var tool_bar       = find_node("ToolBar")
onready var output_display = find_node("OutputDisplay")

onready var about_dialog = find_node("AboutDialog")
onready var file_dialog  = find_node("FileDialog")

func search_file() -> void:
    var line : String

    tool_bar.disable_buttons()
    while file.eof_reached() == false:
        total_lines += 1
        line = file.get_line()

        if parser.search_line(line) == true:
            matching_lines += 1
            display_line(line)

    display_stats()
    tool_bar.enable_buttons()


func display_stats() -> void:
    var text : String

    text = String(matching_lines) + " filtered/" + String(total_lines)
    text += " total lines"

    top_menu.set_text_top_right_label(text)


func display_line(p_line : String) -> void:
    output_display.append_text(p_line)


func reset_counters() -> void:
    matching_lines = 0
    total_lines    = 0


func _on_ToolBar_start_button_pressed(p_filters : Array) -> void:
    reset_counters()
    output_display.clear()
    parser.set_filters(p_filters)

    file.seek(0)
    search_file()


func _on_ToolBar_switch_mode_button_pressed() -> void:
    parser.switch_mode()


func _on_ToolBar_switch_case_sensitive_button_pressed() -> void:
    parser.switch_case_sensitivity()


func _on_FileDialog_file_selected(p_path : String) -> void:
    tool_bar.enable_buttons()
    top_menu.set_text_top_label(p_path)

    file.open(p_path, File.READ)


func _on_TopMenu_open_file_button_pressed() -> void:
    file_dialog.popup_centered()


func _on_TopMenu_about_button_pressed() -> void:
    about_dialog.popup_centered()
