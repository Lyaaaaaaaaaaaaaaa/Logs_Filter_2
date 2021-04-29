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
#------------------------------------------------------------------------------
class_name Parser
extends Object

enum Mode {AND = 0, OR = 1}

var _Regex   := RegEx.new()
var _filters := []
var _mode : int = Mode.AND

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

    _Regex.compile(expression)
