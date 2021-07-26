#------------------------------------------------------------------------------
#-- Copyright (c) 2021 Lyaaaaaaaaaaaaaaa
#--
#-- Author : Lyaaaaa
#--
#-- Implementation Notes:
#--  -
#-- Changelog:
#--  - 22/07/2021 Lyaaaaa
#--    - Created the file.
#------------------------------------------------------------------------------
extends WindowDialog

signal line_separation_changed
signal left_margin_changed
signal font_changed
signal font_size_changed
signal font_color_changed
signal selection_color_changed

var preferences = Preferences.new()

var _line_separation_spin_box      : SpinBox
var _font_size_spin_box            : SpinBox
var _font_item_list                : ItemList
var _font_color_picker_button      : ColorPickerButton
var _selection_color_picker_button : ColorPickerButton


func _ready() -> void:
    _init_variables()
    set_default_values(preferences.output_display)


func _init_variables() -> void:
    _line_separation_spin_box      = find_node("LineSeparationSpinBox")
    _font_size_spin_box            = find_node("FontSizeSpinBox")
    _font_item_list                = find_node("FontItemList")
    _font_color_picker_button      = find_node("FontColorPickerButton")
    _selection_color_picker_button = find_node("SelectionColorPickerButton")


func set_default_values(p_values : Dictionary) -> void:
    _line_separation_spin_box.value = p_values["line_separation"]
    _font_size_spin_box.value       = p_values["font_size"]

    _font_color_picker_button.color      = p_values["font_color"]
    _selection_color_picker_button.color = p_values["selection_color"]


func _on_FontItemList_item_selected(index) -> void:
    var font_name = _font_item_list.get_item_text(index)
    preferences.output_display["font"] = font_name
    emit_signal("font_changed", font_name)


func _on_LineSeparationSpinBox_value_changed(p_value) -> void:
    preferences.output_display["line_separation"] = p_value
    emit_signal("line_separation_changed", p_value)


func _on_FontSizeSpinBox_value_changed(p_value) -> void:
    preferences.output_display["font_size"] = p_value
    emit_signal("font_size_changed", p_value)


func _on_FontColorPickerButton_color_changed(p_color) -> void:
    preferences.output_display["font_color"] = p_color
    emit_signal("font_color_changed", p_color)


func _on_SelectionColorPickerButton_color_changed(p_color) -> void:
    preferences.output_display["selection_color"] = p_color
    emit_signal("selection_color_changed", p_color)


func _on_SaveButton_pressed() -> void:
    preferences.save()
    self.hide()


func _on_CloseButton_pressed() -> void:
    self.hide()
