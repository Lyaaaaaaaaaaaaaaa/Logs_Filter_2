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
#------------------------------------------------------------------------------
extends Panel

var _rich_label : RichTextLabel

func _ready() -> void:
    _init_variables()


func append_text(p_text : String) -> void:
    _rich_label.add_text(p_text + "\n")


func clear() -> void:
    _rich_label.clear()


func _init_variables() -> void:
    _rich_label = find_node("RichLabel")

