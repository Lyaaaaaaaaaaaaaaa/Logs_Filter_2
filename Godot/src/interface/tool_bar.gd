#------------------------------------------------------------------------------
#-- Copyright (c) 2021 Lyaaaaaaaaaaaaaaa
#--
#-- Author : Lyaaaaaaaaaaaaaaa
#--
#-- Implementation Notes:
#--  -
#-- Changelog:
#--  - 29/04/2021 Lyaaaaa
#--    - Created the file and implemented it.
#--
#--  - 30/04/2021 Lyaaaaa
#--    - Added switch_case_sensitive_button_pressed signal
#--    - _switch_case_sensitive_button var
#--    - _init_variables now init _switch_case_sensitive_button
#--    - disable_buttons and enable_buttons now edit
#--        _switch_case_sensitive_button.disabled
#--    - Added _on_SwitchCaseSensitiveButton_pressed signal handler.
#--
#--  - 19/07/2021 Lyaaaaa
#--    - Renamed _start_button into _search_button. Also renamed the signal and
#--        function related.
#--    - Added a variable "_display_all_button" named after the new button.
#--    - Updated disable_buttons, enable_buttons and _init_variables to add take
#--        care of this new variable.
#--    - Added a signal handler _on_DisplayAllButton_pressed which emits the
#--        signal display_all_button_pressed.
#--    - Declared _on_SwitchCaseSensitiveButton_pressed returns a void.
#------------------------------------------------------------------------------
extends Panel

signal search_button_pressed
signal display_all_button_pressed
signal switch_mode_button_pressed
signal switch_case_sensitive_button_pressed

var _search_button       : Button
var _display_all_button  : Button
var _line_edit          : LineEdit

var _switch_mode_button           : CheckButton
var _switch_case_sensitive_button : CheckButton

func _ready() -> void:
    _init_variables()


func disable_buttons() -> void:
    _search_button.disabled                = true
    _switch_mode_button.disabled           = true
    _switch_case_sensitive_button.disabled = true
    _display_all_button.disabled           = true


func enable_buttons() -> void:
    _search_button.disabled                = false
    _switch_mode_button.disabled           = false
    _display_all_button.disabled           = false
    _switch_case_sensitive_button.disabled = false


func _init_variables() -> void:
    _search_button                = find_node("SearchButton")
    _display_all_button           = find_node("DisplayAllButton")
    _line_edit                    = find_node("LineEdit")
    _switch_mode_button           = find_node("SwitchModeButton")
    _switch_case_sensitive_button = find_node("SwitchCaseSensitiveButton")


func _extract_filters() -> Array:
    var regex   := RegEx.new()
    var filters := []

    regex.compile("\\S+")

    for filter in regex.search_all(_line_edit.text):
        filters.push_back(filter.get_string())

    return filters


func _on_SearchButton_pressed() -> void:
    if _line_edit.text == "":
        _line_edit.placeholder_text = "Please enter filters"

    else:
        var filters := []
        filters = _extract_filters()
        emit_signal("search_button_pressed", filters)


func _on_SwitchModeButton_pressed() -> void:
    emit_signal("switch_mode_button_pressed")


func _on_SwitchCaseSensitiveButton_pressed() -> void:
    emit_signal("switch_case_sensitive_button_pressed")


func _on_DisplayAllButton_pressed() -> void:
    emit_signal("display_all_button_pressed")
