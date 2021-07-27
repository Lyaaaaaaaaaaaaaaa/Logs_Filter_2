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
#--
#--  - 27/07/2021 Lyaaaaa
#--    - Declared a preferences object.
#--    - Added _on_PlusButton_pressed and _on_MinusButton_pressed functions.
#--    - preferences object is used in these two functions to save the new value
#--        of the font size.
#--    - Updated _load_preferences to adapt to the changes. preferences becomes
#--        settings.
#--    - Deleted the _clipboard_button and replaced it with _buttons_container.
#--    - Declared the return type of the forgotten functions.
#------------------------------------------------------------------------------
extends Panel

var _rich_label        : RichTextLabel
var _buttons_container : HBoxContainer
var _rich_label_font   : DynamicFont
var font_data_path     :=  "res://assets/fonts/"
var preferences        := Preferences.new()


func _ready() -> void:
    _init_variables()
    _load_preferences()


func append_text(p_text : String) -> void:
    _rich_label.add_text(p_text + "\n")
    _buttons_container.visible = true


func clear() -> void:
    _rich_label.clear()
    _buttons_container.visible = false


func _init_variables() -> void:
    _rich_label        = find_node("RichLabel")
    _buttons_container = find_node("ButtonsContainer")
    _rich_label_font   = _rich_label.get_font("normal_font")


func _load_preferences() -> void:
    var settings        = preferences.output_display
    var font_name       = settings["font"]
    var font_color      = settings["font_color"]
    var font_size       = settings["font_size"]
    var line_separation = settings["line_separation"]
    var selection_color = settings["selection_color"]

    _rich_label_font.font_data = load(font_data_path + font_name + ".ttf")
    _rich_label_font.size      = font_size

    _rich_label.add_constant_override("line_separation", line_separation)
    _rich_label.add_color_override("selection_color", selection_color)
    _rich_label.add_color_override("default_color", font_color)


func _on_ClipboardButton_pressed() -> void:
    var Os   := OS
    Os.set_clipboard(_rich_label.text)


func _on_PreferencesDialog_font_changed(p_font_name : String) -> void:
    _rich_label_font.font_data = load(font_data_path + p_font_name + ".ttf")


func _on_PreferencesDialog_font_color_changed(p_color : Color) -> void:
    _rich_label.add_color_override("default_color", p_color)


func _on_PreferencesDialog_font_size_changed(p_value : int) -> void:
    _rich_label_font.size = p_value


func _on_PreferencesDialog_line_separation_changed(p_value : int) -> void:
    _rich_label.add_constant_override("line_separation", p_value)


func _on_PreferencesDialog_selection_color_changed(p_color : Color) -> void:
    _rich_label.add_color_override("selection_color", p_color)


func _on_PlusButton_pressed() -> void:
    _rich_label_font.size += 1
    preferences.output_display["font_size"] += 1
    preferences.save()
    

func _on_MinusButton_pressed() -> void:
    _rich_label_font.size -= 1
    preferences.output_display["font_size"] -= 1
    preferences.save()
