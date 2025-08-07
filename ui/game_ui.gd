extends Control

@onready var combo_label: RichTextLabel = $ComboLabel
@export var current_funds : FundRes
@export var current_score : ScoreValue

@export var info_msg_scene : PackedScene

@export_group("Debug")
@export var debug_enabled : bool = false
@export var speed_stat : StatValue
@export var grind_stat : StatValue
@export var trick_points : PointValue
@export var trick_multiplier_debug : PointValue

var info_messages : Dictionary[Global.FundReason, String] = {
	Global.FundReason.COIN_PICKUP: "Coin collected!",
	Global.FundReason.GRIND_100: "Grinded 100 points!",
	Global.FundReason.TRICK_10: "10 tricks!",
	Global.FundReason.TRICK_1: "Trick!"
}

func _ready():
	current_funds.value_changed.connect(_on_funds_value_changed)
	_on_funds_value_changed(current_funds.value,0, Global.FundReason.NONE)

func _process(_delta):
	if OS.is_debug_build() and debug_enabled:
		var _debug_text : String = ""
		var grind_fund_recharge = 100.0 * (speed_stat.value/1000.0) / grind_stat.value
		_debug_text = "Grind gives $50 every %.2f seconds (%d ms, %dgpts)"%[grind_fund_recharge,speed_stat.value,grind_stat.value]
		_debug_text += "\n"
		_debug_text += "%s points from tricks"%Global.int_to_big(trick_points.value * trick_multiplier_debug.value).toMetricSymbol(true)

		$DebugData.text = _debug_text
	if current_score:
		if current_score.value > -1:
			$ScoreLabel.text = current_score.as_big().toMetricSymbol(true)
		else:
			$ScoreLabel.text = "NaN" 
	pass

func show_combo(grind_score : int, trick_score: int, trick_multiplier: int) -> void:
	var combo_text = format_grind_score(grind_score)
	if trick_score > 0:
		if trick_multiplier > 1:
			combo_text +=" + "+format_trick_score(trick_score, trick_multiplier) 
		else:
			combo_text +=" + "+Global.int_to_big(trick_score).toMetricSymbol(true)

	combo_label.text = combo_text

func format_grind_score(grind_score: int) -> String:
	return "%s" % Global.int_to_big(grind_score).toMetricSymbol(true)

func format_trick_score(trick_score: int, trick_multiplier: int) -> String:
	return "%d x %d" % [trick_score, trick_multiplier]

func _on_funds_value_changed(new_value: int,amount : int, reason : Global.FundReason) -> void:
	$FundsLabel.text = "$%d" % new_value
	if new_value == 0:
		return
	var tween := create_tween()
	tween.tween_property($FundsLabel, "scale", Vector2(1.5, 1.5), 0.2)
	tween.tween_property($FundsLabel, "scale", Vector2(1, 1), 0.2)
	spawn_info_message(amount, reason)

func spawn_info_message(amount, reason: Global.FundReason) -> void:
	if reason == Global.FundReason.NONE or reason == Global.FundReason.BOUGHT_UPGRADE:
		return 

	var msg = info_messages.get(reason, "Unknown event") + " ($%d)"%amount
	var info_msg_instance = info_msg_scene.instantiate()
	$MsgStartPoint.add_child(info_msg_instance)
	info_msg_instance.start(msg)
