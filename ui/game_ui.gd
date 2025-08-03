extends Control

@onready var combo_label: RichTextLabel = $ComboLabel
@export var current_funds : FundRes

func _ready():
	current_funds.value_changed.connect(_on_funds_value_changed)
	_on_funds_value_changed(current_funds.value)  

func show_combo(grind_score : int, trick_score: int, trick_multiplier: int) -> void:
	var combo_text = format_grind_score(grind_score)
	if trick_multiplier > 0 and trick_score > 0:
		combo_text +=" + "+format_trick_score(trick_score, trick_multiplier) 

	combo_label.text = combo_text

func format_grind_score(grind_score: int) -> String:
	return "%d" % grind_score

func format_trick_score(trick_score: int, trick_multiplier: int) -> String:
	return "%d x %d" % [trick_score, trick_multiplier]

func _on_funds_value_changed(new_value: int) -> void:
	var tween := create_tween()
	$FundsLabel.text = "$%d" % new_value
	tween.tween_property($FundsLabel, "scale", Vector2(1.5, 1.5), 0.2)
	tween.tween_property($FundsLabel, "scale", Vector2(1, 1), 0.2)
