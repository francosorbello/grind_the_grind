extends Control

@onready var combo_label: RichTextLabel = $ComboLabel
@export var current_funds : FundRes

@export var info_msg_scene : PackedScene

var info_messages : Dictionary[Global.FundReason, String] = {
	Global.FundReason.COIN_PICKUP: "Coin collected!",
	Global.FundReason.GRIND_100: "Grinded 100 points!",
	Global.FundReason.TRICK_10: "10 tricks!"
}

func _ready():
	current_funds.value_changed.connect(_on_funds_value_changed)
	_on_funds_value_changed(current_funds.value, Global.FundReason.NONE)

func show_combo(grind_score : int, trick_score: int, trick_multiplier: int) -> void:
	var combo_text = format_grind_score(grind_score)
	if trick_multiplier > 0 and trick_score > 0:
		combo_text +=" + "+format_trick_score(trick_score, trick_multiplier) 

	combo_label.text = combo_text

func format_grind_score(grind_score: int) -> String:
	return "%d" % grind_score

func format_trick_score(trick_score: int, trick_multiplier: int) -> String:
	return "%d x %d" % [trick_score, trick_multiplier]

func _on_funds_value_changed(new_value: int, reason : Global.FundReason) -> void:
	$FundsLabel.text = "$%d" % new_value
	if new_value == 0:
		return
	var tween := create_tween()
	tween.tween_property($FundsLabel, "scale", Vector2(1.5, 1.5), 0.2)
	tween.tween_property($FundsLabel, "scale", Vector2(1, 1), 0.2)
	spawn_info_message(reason)

func spawn_info_message(reason: Global.FundReason) -> void:
	if reason == Global.FundReason.NONE or reason == Global.FundReason.BOUGHT_UPGRADE:
		return 

	var msg = info_messages.get(reason, "Unknown event")
	var info_msg_instance = info_msg_scene.instantiate()
	$MsgStartPoint.add_child(info_msg_instance)
	info_msg_instance.start(msg)
