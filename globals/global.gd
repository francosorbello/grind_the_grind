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
    BOUGHT_UPGRADE,
}