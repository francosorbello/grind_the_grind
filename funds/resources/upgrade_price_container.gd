extends Resource
## @deprecated: Changed to other system
class_name UpgradePriceContainer

@export var prices : Dictionary[Global.StatType, int] = {
    Global.StatType.GRIND: 25,
    Global.StatType.SPEED: 100,
    Global.StatType.TRICK: 25,
}