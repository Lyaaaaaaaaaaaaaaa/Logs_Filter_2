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
#--    - Created the file.
#--
#--  - 26/05/2021 Lyaaaaa
#--    - Implemented the tests.
#------------------------------------------------------------------------------

extends WAT.Test

var parser  : Parser
var context : String

func pre() -> void:
    parser = Parser.new()


func post() -> void:
    parser.free()
    context = ""


func test_default_values() -> void:
    describe("When a Parser is created")


    context = "Parser's mode is set to AND mode."
    asserts.is_equal(parser._mode, parser.Mode.AND, context)

    context = "Parser isn't case sensitive"
    asserts.is_false(parser._case_sensitive, context)


func test_set_filters() -> void:
    var parser  = Parser.new()
    var filters = ["Words1", "Words2"]

    parser.set_filters(filters)
    asserts.is_false(parser._filters.empty())


func test_search_line() -> void:
    describe("When searching in a line")
    var line1   : String
    var line2   : String
    var filters : Array

    filters = ["line", "sample"]
    line1   = "This is a sample line"
    line2   = "This is a line"

    parser.set_filters(filters)

    context = "where all the keywords are present"
    asserts.is_true(parser.search_line(line1), context)

    context = "where a keyword is absent (search mode = AND)"
    asserts.is_false(parser.search_line(line2), context)


func test_set_mode() -> void:
    parser.set_mode(parser.Mode.OR)
    asserts.is_equal(parser._mode, parser.Mode.OR)


func test_switch_mode() -> void:
    var previous_mode : int
    previous_mode = parser._mode

    parser.switch_mode()
    asserts.is_not_equal(previous_mode, parser._mode)


func test_switch_case_sensitivity() -> void:
    var previous_case_sensitive : bool
    previous_case_sensitive = parser._case_sensitive

    parser.switch_case_sensitivity()
    asserts.is_not_equal(previous_case_sensitive, parser._case_sensitive)


func test_set_regex() -> void:
    describe("When the regex is compiled")

    parser._set_regex()
    context = "Is the regex valid while Parser is set to AND mode"
    asserts.is_true(parser._Regex.is_valid(), context)

    parser.set_mode(parser.Mode.OR)
    parser._set_regex()
    context = "Is the regex valid while Parser is set to OR mode"
    asserts.is_true(parser._Regex.is_valid(), context)

func test_add_case_insensitivity() -> void:
    var string : String

    string = parser._add_case_insensitivity("")
    asserts.is_equal(string, "(?i)")
