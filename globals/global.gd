extends Node
class_name Global

enum StatType {
    GRIND,
    SPEED, # speed is in milliseconds
    TRICK,
}

enum ScoreType {
    CURRENT,
    FINAL,
}

enum TrickType {
    TRICK_Z,
    TRICK_x,
    TRICK_C    
}

enum FundReason {
    NONE,
    COIN_PICKUP,
    GRIND_100,
    TRICK_10,
    TRICK_1,
    BOUGHT_UPGRADE,
}

enum ModType {
    WHEELS_BRONZE,
    WHEELS_PLAT,
    WHEELS_GOLD,
    SKATE_BRONZE,
    SKATE_PLAT,
    SKATE_GOLD
}

static func int_to_big(n : int) -> Big:
    if n > Big.MANTISSA_MAX:
        var number_of_digits : int = floor(log(n)/log(10))+1
        return Big.new(float(n)/pow(10,number_of_digits-2),number_of_digits-2)
    return Big.new(n)