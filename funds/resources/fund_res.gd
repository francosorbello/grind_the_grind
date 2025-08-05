extends Resource
class_name FundRes

signal value_changed(value : int,reason : Global.FundReason)

@export var value: int = 0

func add_funds(amount: int, reason : Global.FundReason = Global.FundReason.NONE) -> void:
    value += amount
    value_changed.emit(value,reason)

func subtract_funds(amount: int) -> void:
    if (value-amount) < 0:
        push_warning("Substracting more funds than available")
        return
    value = value - amount
    value_changed.emit(value, Global.FundReason.BOUGHT_UPGRADE)

func reset():
    value = 0