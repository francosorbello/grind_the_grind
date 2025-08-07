extends Control
class_name StoreButton

@export var stat_type : Global.StatType

@export_group("Funds")
@export var related_price : PriceResource
@export var funds : FundRes 

@export_group("Resources")
@export var icons : Dictionary[Global.StatType, Texture2D]

@onready var button : Button = $Button

var titles : Dictionary[Global.StatType, String] = {
	Global.StatType.SPEED: "Speed",
	Global.StatType.GRIND: "Grind",
	Global.StatType.TRICK: "Trick",
}

var hints : Dictionary[Global.StatType, String] = {
	Global.StatType.SPEED: "Increase the speed you gain points while grinding.",
	Global.StatType.GRIND: "Increase the amount of points obtained while grinding.",
	Global.StatType.TRICK: "Increase the amount of points obtained by doing tricks.",
}

signal on_store_button_pressed(stat_type: Global.StatType)

func _ready():
	related_price.upgrade_incremented.connect(_on_upgrade_incremented)
	setup()

func setup():
	button.icon = icons.get(stat_type, null)
	set_text()
	button.tooltip_text = hints.get(stat_type, "No hint available.")

func set_text():
	button.text = "Upgrade" + " " + titles.get(stat_type, "Unknown") + "($%d)" % related_price.get_price()

func _on_button_pressed() -> void:
	on_store_button_pressed.emit(stat_type)

func _on_upgrade_incremented():
	set_text()	
	pass

func _process(_delta: float) -> void:
	if funds.value < related_price.get_price():
		button.disabled = true
	else:
		button.disabled = false
