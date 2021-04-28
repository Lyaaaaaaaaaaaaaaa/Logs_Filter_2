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
#------------------------------------------------------------------------------
extends Object
class_name Parser

enum Mode {AND = 0, OR = 1}

var Regex   := RegEx.new()
var filters := []
var mode  : int = Mode.AND

func search_line(p_line : String) -> bool:
    var result = Regex.search(p_line)

    if result != null:
        return true

    else:
        return false

func __set_regex() -> void:
    var expression : String

    if mode == Mode.AND:
        for i in filters.size():
            expression += "(?=.*" + filters[i] + ")" # é != e with this regex.

    elif mode == Mode.OR:
        for i in filters.size():
            expression += "(" + filters[i] + ")" # é == e with this regex.

            if i < filters.size() - 1:
                expression += "|"

    Regex.compile(expression)

func set_filters(p_filters : Array) -> void:
    filters = p_filters
    self.__set_regex()

func set_mode(p_mode : int) -> void:
    mode = p_mode
    self.__set_regex()

