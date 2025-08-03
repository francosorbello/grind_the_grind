extends Node

var _rect_to_fix : ColorRect

func _ready() -> void:
    _rect_to_fix = get_tree().get_first_node_in_group("ui_to_fix")
    if _rect_to_fix:
        _rect_to_fix.mouse_filter = Control.MOUSE_FILTER_IGNORE