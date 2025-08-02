extends Control

@export var stat_type : Global.StatType

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
    setup()

func setup():
    button.icon = icons.get(stat_type, null)
    button.text = "Upgrade" + " " + titles.get(stat_type, "Unknown")
    button.tooltip_text = hints.get(stat_type, "No hint available.")

func _on_button_pressed() -> void:
    on_store_button_pressed.emit(stat_type)
