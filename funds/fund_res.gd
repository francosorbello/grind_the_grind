extends Resource
class_name FundRes

signal value_changed(value : int,reason : Global.FundReason)

@export var value: int = 0

func add_funds(amount: int, reason : Global.FundReason = Global.FundReason.NONE) -> void:
    value += amount
    value_changed.emit(value,reason)

func subtract_funds(amount: int, reason : Global.FundReason = Global.FundReason.NONE) -> void:
    value = max(0, value - amount)
    value_changed.emit(value, reason)

func reset():
    value = 0