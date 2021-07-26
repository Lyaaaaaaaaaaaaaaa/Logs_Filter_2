#------------------------------------------------------------------------------
#-- Copyright (c) 2021 Lyaaaaaaaaaaaaaaa
#--
#-- Author : Lyaaaaa
#--
#-- Implementation Notes:
#--  - Class to save and load the preferences into and from a file.
#--
#-- Anticipated changes:
#--  - Add another dictionnary for each new element that uses the preferences.
#--      Could add an id key in the dictionnary to not need anymore to take care
#--      of the order in which are saved the dictionnaries.
#--  - Add another element in the Save_Order enum.
#--  - Add a loop and control in load to correctly load the different elements.
#--
#-- Changelog:
#--  - 22/07/2021 Lyaaaaa
#--    - Created the file.
#--
#--  - 23/07/2021 Lyaaaaa
#--    - Finished implementing it.
#--
#--  - 26/07/2021 Lyaaaaa
#--    - Deleted a comment from the save function.
#------------------------------------------------------------------------------
class_name Preferences
extends Object

enum Save_Order {OUTPUT_DISPLAY = 1}

var output_display = {
    "line_separation" : 7,
    "font"            : "DejaVuSansMono",
    "font_size"       : 14,
    "font_color"      : Color("#deddda"),
    "selection_color" : Color("#1a5fb4")
}

var file      := File.new()
var file_path := "user://preferences"

func _init() -> void:
    if file.file_exists(file_path):
        self.load()


func save() -> void:
    file.open(file_path, File.WRITE)
    file.store_var(output_display)
    file.close()


func load() -> void:
    file.open(file_path, File.READ)
    output_display = file.get_var()
    file.close()
