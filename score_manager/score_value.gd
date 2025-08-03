extends Resource
class_name ScoreValue

@export var type: Global.ScoreType
@export var value: int

func increment_by(amount: int) -> void:
    value += amount

func reset() -> void:
    value = 0

func as_big() -> Big:
    return Big.new(value)