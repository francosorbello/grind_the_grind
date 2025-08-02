extends Resource
class_name StatValue

@export var type: Global.StatType 
@export var initial_value: int 
@export var value: int 

func increment_by(amount: int) -> void:
    value += amount

func reset() -> void:
    print(type, "reseting %d to %d" % [value, initial_value])
    value = initial_value