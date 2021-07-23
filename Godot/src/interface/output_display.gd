#------------------------------------------------------------------------------
#-- Copyright (c) 2021 Lyaaaaaaaaaaaaaaa
#--
#-- Author : Lyaaaaa
#--
#-- Implementation Notes:
#--  -
#-- Changelog:
#--  - 29/04/2021 Lyaaaaa
#--    - Created the file and implemented it.
#--
#--  - 20/07/2021 Lyaaaaa
#--    - Added the _clipboard_button var.
#--    - Updated append_text and clear to set visible and invisible the new
#--        clipboard button.
#--    - Updated _init_variables to init _clipboard_button.
#--    - Added the _on_ClipboardButton_pressed.
#--
#--  - 23/07/2021 Lyaaaaa
#--    - Added _rich_label_font and font_data_path variables.
#--    - Updated _init_variables to init _rich_label_font.
#--    - Updated _ready to call _load_preferences
#--    - Added _load_preferences fonction.
#--    - Added the signal handlers to update in real time the display.
#------------------------------------------------------------------------------
extends Panel

var _rich_label       : RichTextLabel
var _clipboard_button : Button
var _rich_label_font  : DynamicFont
var font_data_path    :=  "res://assets/fonts/"

func _ready() -> void:
    _init_variables()
    _load_preferences()

func append_text(p_text : String) -> void:
    _rich_label.add_text(p_text + "\n")
    _clipboard_button.visible = true

func clear() -> void:
    _rich_label.clear()
    _clipboard_button.visible = false


func _init_variables() -> void:
    _rich_label        = find_node("RichLabel")
    _clipboard_button  = find_node("ClipboardButton")
    _rich_label_font   = _rich_label.get_font("normal_font")


func _load_preferences() -> void:
    var preferences     = Preferences.new().output_display
    var font_name       = preferences["font"]
    var font_color      = preferences["font_color"]
    var font_size       = preferences["font_size"]
    var line_separation = preferences["line_separation"]
    var selection_color = preferences["selection_color"]

    _rich_label_font.font_data = load(font_data_path + font_name + ".ttf")
    _rich_label_font.size      = font_size

    _rich_label.add_constant_override("line_separation", line_separation)
    _rich_label.add_color_override("selection_color", selection_color)
    _rich_label.add_color_override("default_color", font_color)


func _on_ClipboardButton_pressed() -> void:
    var Os   := OS
    Os.set_clipboard(_rich_label.text)


func _on_PreferencesDialog_font_changed(p_font_name : String):
    _rich_label_font.font_data = load(font_data_path + p_font_name + ".ttf")


func _on_PreferencesDialog_font_color_changed(p_color : Color):
    _rich_label.add_color_override("default_color", p_color)


func _on_PreferencesDialog_font_size_changed(p_value : int):
    _rich_label_font.size = p_value


func _on_PreferencesDialog_line_separation_changed(p_value : int):
    _rich_label.add_constant_override("line_separation", p_value)


func _on_PreferencesDialog_selection_color_changed(p_color : Color):
    _rich_label.add_color_override("selection_color", p_color)
