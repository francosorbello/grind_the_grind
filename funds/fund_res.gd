extends Resource
class_name FundRes

signal value_changed(int)

@export var value: int = 0

func add_funds(amount: int) -> void:
    value += amount
    value_changed.emit(value)

func subtract_funds(amount: int) -> void:
    value = max(0, value - amount)
    value_changed.emit(value)

func reset():
    value = 0