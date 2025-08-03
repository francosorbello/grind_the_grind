extends Node
class_name ScoreManager

@export var current_score : ScoreValue

@export var grind_points : PointValue
@export var trick_multiplier : PointValue
@export var trick_points : PointValue # trick points should increment when doing tricks, based on value of trick_stat. on final_score, this value is multiplied by trick_multiplier

@export_group("Stats")
@export var stats : Dictionary[Global.StatType, StatValue]
@export var current_funds : FundRes
@export var prices_container : UpgradePriceContainer

@export_group("UI")
@export var game_ui : Control

var _grind_fund_treshold : int = 100 #every 100 grind points, funds are added
var _multiplier_fund_treshold : int = 10 #every 10 tricks, funds are added

func _ready():
    $GrindingTimer.timeout.connect(on_grinding_timeout)
    for stat in stats.values():
        stat.reset()  # Reset all stats to their initial values when the game starts

# increment a stat via ui
func increment_stat(stat_type: Global.StatType, amount: int) -> void:
    stats[stat_type].increment_by(amount)
    # print("incrementing stat %s by %d" % [stat_type, amount])
    purchase_stat(stat_type)  # Deduct funds when a stat is incremented

func decrement_stat(stat_type: Global.StatType, amount: int) -> void:
    stats[stat_type].decrement_by(amount)
    # print("decrementing stat %s by %d" % [stat_type, amount])
    purchase_stat(stat_type)  # Deduct funds when a stat is decremented

func purchase_stat(stat_type : Global.StatType):
    current_funds.subtract_funds(prices_container.prices.get(stat_type,0))

#region Increment Functions
func upgrade_stat(stat_type: Global.StatType) -> void:
    match stat_type:
        Global.StatType.SPEED:
            increment_speed()
        Global.StatType.GRIND:
            increment_grind()
        Global.StatType.TRICK:
            increment_trick()
        _:
            print("Unknown stat type: ", stat_type)

func increment_grind():
    $GrindManager.increment(self)

func increment_trick():
    $TrickManager.increment(self)

func increment_speed():
    $SpeedManager.increment(self)
    $GrindingTimer.stop()
    set_grinding(true) 
#endregion

# increment grind points while grinding
func increment_grind_points() -> void:
    grind_points.value += stats[Global.StatType.GRIND].value
    if grind_points.value >= _grind_fund_treshold:
        current_funds.add_funds(10 + grind_points.value * 0.01 as int, Global.FundReason.GRIND_100) # Add 10% of grind points as funds
        _grind_fund_treshold += 100
    calculate_current_score()

func do_trick() -> void:
    trick_points.value += stats[Global.StatType.TRICK].value
    increment_trick_multiplier()  # Increment the trick multiplier when a trick is done
    calculate_current_score()
    if trick_multiplier.value >= _multiplier_fund_treshold:
        current_funds.add_funds(5 + stats[Global.StatType.TRICK].value * 0.01 as int, Global.FundReason.TRICK_10) # Add 1% of trick points as funds
        _multiplier_fund_treshold += 10

func increment_trick_multiplier():
    trick_multiplier.value += 1 

# calculate the current score based on grind points and trick multiplier
func calculate_current_score() -> int:
    var total_score = grind_points.value + trick_multiplier.value * trick_points.value 
    current_score.value = total_score
    # print("current score: ",current_score.value)
    game_ui.show_combo(grind_points.value, trick_points.value, trick_multiplier.value)
    return total_score

func set_grinding(is_grinding: bool) -> void:
    if is_grinding:
        $GrindingTimer.start(stats[Global.StatType.SPEED].value / 1000.0)  # Convert milliseconds to seconds
    else:
        $GrindingTimer.stop()
    
func on_grinding_timeout() -> void:
    increment_grind_points()