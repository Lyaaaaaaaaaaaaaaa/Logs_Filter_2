#------------------------------------------------------------------------------
#-- Copyright (c) 2020 Lyaaaaaaaaaaaaaaa
#--
#-- Author : Lyaaaaa
#--
#-- Portability Issues:
#--  - Works only with WAT plugin
#--
#-- Implementation Notes:
#--  - Unit testing file for the Parser class
#
#-- Changelog:
#--  - 28/04/2021 Lyaaaaa
#--       - Created the file.
#------------------------------------------------------------------------------

extends WAT.Test

func test_set_filters() -> void:
    var parser  = Parser.new()
    var filters = ["Words1", "Words2"]

    parser.set_filters(filters)
    asserts.is_false(parser.filters.empty())
