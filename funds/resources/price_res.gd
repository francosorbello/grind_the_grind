extends Resource
class_name PriceResource

@export var initial_price : float

@export_category("Formula")
@export var coefficient : float = 3

var number_of_upgrades : int = 0

signal upgrade_incremented

func increment_upgrade():
    number_of_upgrades += 1
    upgrade_incremented.emit()
    print("Upgrade incremented to %d. Next price will be %d"%[number_of_upgrades,get_price()])

# func get_price() -> int:
#     return int(initial_price + pow(coefficient,number_of_upgrades-1)) 

func get_price() -> int:
    return int(initial_price * pow(coefficient,number_of_upgrades)) 

func reset():
    number_of_upgrades = 0
