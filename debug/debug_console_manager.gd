extends Node

@export var current_funds : FundRes

func _ready() -> void:
    Console.add_command("add_funds",add_funds,1)
    Console.add_command("add_10000",add_10000)
    Console.add_command("clear_funds",clear_funds)
    pass

func add_funds(amount : String):
    current_funds.add_funds(int(amount))

func add_10000():
    add_funds("10000")

func clear_funds():
    current_funds.subtract_funds(current_funds.value)