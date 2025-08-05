extends Control

@export var score_manager : ScoreManager

func _ready():
	$VBoxContainer.scale = Vector2(1, 0)  # Start collapsed


func open():
	var tween = create_tween()
	tween.tween_property($VBoxContainer, "scale", Vector2(1, 1), 0.2)

func close():
	var tween = create_tween()
	tween.tween_property($VBoxContainer, "scale", Vector2(1, 0), 0.2)
	$TutorialNotifier.notify()


func _on_close_button_pressed() -> void:
	close()
	$OpenButton.visible = true
	$ClickSound.play()
	pass # Replace with function body.


func _on_open_button_pressed() -> void:
	$OpenButton.visible = false
	open()
	$ClickSound.play()


func _on_upgrade_stat(stat_type: Global.StatType) -> void:
	score_manager.upgrade_stat(stat_type)
	$ClickSound.play()
	pass
