extends Resource
class_name ScoreValue

@export var type: Global.ScoreType
@export var value: int

func increment_by(amount: int) -> void:
	value += amount

func reset() -> void:
	value = 0

func as_big() -> Big:
	if value > Big.MANTISSA_MAX:
		var number_of_digits :int = str(value).length()
		return Big.new(value/pow(10,number_of_digits-2),number_of_digits-2)
	return Big.new(value)
