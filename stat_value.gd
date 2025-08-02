extends Resource
class_name StatValue

@export var type: Global.StatType 
@export var initial_value: int 
@export var value: int
@export var min_value: int = 0
@export var max_value: int = 0

func increment_by(amount: int) -> void:
    value += amount
    if max_value > 0 and value > max_value:
        value = max_value  # Ensure value does not exceed max_value

func decrement_by(amount: int) -> void:
    value -= amount
    if value < 0:
        value = 0  # Ensure value does not go below zero

func reset() -> void:
    value = initial_value