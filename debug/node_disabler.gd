@tool
extends Node

var _prev_parent_process_mode
var _prev_self_prcess_node

@export var disabled : bool:
    set(new_value):
        if new_value:
            disable()
        else:
            enable()
        disabled = new_value

func disable() -> void:
    var parent : Node = get_parent()
    if parent:
        _prev_parent_process_mode = parent.process_mode
        _prev_self_prcess_node = process_mode
        parent.process_mode = Node.PROCESS_MODE_DISABLED
        process_mode = Node.PROCESS_MODE_ALWAYS
        print("parent changed from %s to %s"%[_prev_parent_process_mode,parent.process_mode])

func enable():
    var parent : Node = get_parent()
    if parent:
        print("enable the parent again %s"%_prev_parent_process_mode)
        parent.process_mode = _prev_parent_process_mode
        _prev_parent_process_mode = null


