#------------------------------------------------------------------------------
#-- Copyright (c) 2021 Lyaaaaaaaaaaaaaaa
#--
#-- Author : Lyaaaaa
#--
#-- Portability Issues:
#--  - Works only with WAT plugin
#--
#-- Implementation Notes:
#--  - Unit testing file for the Preferences class
#
#-- Changelog:
#--  - 26/07/2021 Lyaaaaa
#--    - Created the file.
#--
#--  - 27/07/2021
#--    - Fixed some errors
#--      - Renamed file_path into _file_path
#--      - Updated post to delete the saved file between two functions.
#--    - Deleted the lines changing the file_path. No need to use a specific 
#--        path to test.
#------------------------------------------------------------------------------

extends WAT.Test

var preferences : Preferences
var context     : String


func pre() -> void:
    preferences = Preferences.new()


func post() -> void:
    var directory = Directory.new()
    directory.remove(preferences._file_path)
    preferences.free()
    context = ""


func test_save() -> void:
    describe("When saving into a file")

    var file := File.new()
    var old_value
    var output_display
    var new_value

    old_value = preferences.output_display["font"]
    preferences.output_display["font"] = "Test"
    preferences.save()
    
    file.open(preferences._file_path, File.READ)

    output_display = file.get_var()
    new_value      = output_display["font"]

    context = "New data saved."
    asserts.is_not_equal(old_value, new_value, context)


func test_load() -> void:
    describe("When loading preferences from a file")

    var output_display

    preferences.output_display["font"] = "Test"
    preferences.save()
    preferences.free()

    preferences = Preferences.new()
    preferences.load()

    output_display = preferences.output_display

    context = "Data loaded"
    asserts.is_equal(output_display["font"], "Test", context)
