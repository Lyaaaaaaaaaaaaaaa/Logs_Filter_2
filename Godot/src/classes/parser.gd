#------------------------------------------------------------------------------
#-- Copyright (c) 2021 Lyaaaaaaaaaaaaaaa
#--
#-- Author : Lyaaaaaaaaaaaaaaa
#--
#-- Implementation Notes:
#--  - 
#-- Changelog:
#--  - 22/04/2021 Lyaaaaa
#--     - Created the empty file.
#--
#--  - 27/04/2021 Lyaaaaa
#--     - Added the variables and enum
#--     - Implemented set_mode, set_filters, search_line and __set_regex.
#--
#--  - 29/04/2021 Lyaaaaa
#--     - Edited the order of the code to fit the style guide.
#--     - Regex, filters and mode are now private variables.
#--     - Added switch_mode method.
#--
#--  - 30/04/2021 Lyaaaaa
#--     - Parser can now enable or disable case sensitivity of its regex.
#--     - Added _case_sensitive var.
#--     - Added switch_case_sensitivity method which set at true or false the
#--         _case_sensitive var.
#--     - Added _add_case_insensitivity method which adds the string to ignore
#--         case sensitivity to the regex.
#------------------------------------------------------------------------------
class_name Parser
extends Object

enum Mode {AND = 0, OR = 1}

var _Regex   := RegEx.new()
var _filters := []

var _mode           : int  = Mode.AND
var _case_sensitive : bool = false

func search_line(p_line : String) -> bool:
    var result = _Regex.search(p_line)

    if result != null:
        return true

    else:
        return false


func set_filters(p_filters : Array) -> void:
    _filters = p_filters
    self._set_regex()


func set_mode(p_mode : int) -> void:
    _mode = p_mode
    self._set_regex()


func switch_mode() -> void:
    if _mode == Mode.AND:
        set_mode(Mode.OR)
    else:
        set_mode(Mode.AND)


func switch_case_sensitivity() -> void:
    if _case_sensitive == false:
        _case_sensitive = true
    else:
        _case_sensitive = false


func _set_regex() -> void:
    var expression : String

    if _mode == Mode.AND:
        for i in _filters.size():
            expression += "(?=.*" + _filters[i] + ")" # é != e with this regex.

    elif _mode == Mode.OR:
        for i in _filters.size():
            expression += "(" + _filters[i] + ")" # é == e with this regex.

            if i < _filters.size() - 1:
                expression += "|"

    if _case_sensitive == false:
        expression = _add_case_insensitivity(expression)

    _Regex.compile(expression)


func _add_case_insensitivity(p_expression : String) -> String:
    p_expression = "(?i)" + p_expression
    return p_expression
