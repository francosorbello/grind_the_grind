extends Node

var _rect_to_fix : ColorRect
var _original_value
func _ready() -> void:
    _rect_to_fix = get_tree().get_first_node_in_group("ui_to_fix")
    IndieBlueprintSceneTransitioner.next_scene_path = ""
    if _rect_to_fix:
        _original_value = _rect_to_fix.mouse_filter
        _rect_to_fix.mouse_filter = Control.MOUSE_FILTER_IGNORE

func unfix():
    if _rect_to_fix:
        _rect_to_fix.mouse_filter = _original_value