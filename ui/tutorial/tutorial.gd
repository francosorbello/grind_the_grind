extends Control

@onready var timer : Timer = $Timer
@export_category("Debug")
@export var debug_disabled : bool = false

var _tutorial_active : bool = false
var _jump_done : bool = false
var _trick_done : bool = false
var _store_closed : bool = false

func _ready() -> void:
    if OS.is_debug_build() and debug_disabled:
        mouse_filter = Control.MOUSE_FILTER_IGNORE
        return
    GlobalEventSystem.suscribe(self, "_on_global_event")
    timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
    $JumpText.visible = true
    _tutorial_active = true

    
func _on_global_event(event, message: Dictionary) -> void:
    if not _tutorial_active:
        return
    if event == GlobalEventSystem.GameEvent.GE_TUTORIAL:
        match message["tutorial"]:
            "jump":
                if _jump_done:
                    return
                $JumpText.visible = false
                $TrickText.visible = true
                _jump_done = true
            "trick":
                if _trick_done or not _jump_done:
                    return
                $TrickText.visible = false
                _trick_done = true
                $StoreText.visible = true
                mouse_filter = Control.MOUSE_FILTER_IGNORE
            "store_closed":
                if _store_closed:
                    return
                $StoreText.visible = false
                _store_closed = true
                _tutorial_active = false
                _show_final_text()


func _show_final_text():
    $EndText.visible = true
    $BailText.visible = true
    $BailTimer.start()

func _on_bail_timer_timeout() -> void:
    var end_text_tween = create_tween()
    end_text_tween.tween_property($EndText, "modulate", Color(1, 1, 1, 0), 3)
    end_text_tween.tween_callback(func(): 
        $EndText.visible = false
        GlobalEventSystem.unsuscribe(self)
    )

    var bail_text_tween = create_tween()
    bail_text_tween.tween_property($BailText, "modulate", Color(1, 1, 1, 0), 3)
    bail_text_tween.tween_callback(func(): 
        $BailText.visible = false
    )
    pass # Replace with function body.
