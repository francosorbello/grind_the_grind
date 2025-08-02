extends Node
class_name ScoreManager

@export var current_score : ScoreValue

@export var grind_points : PointValue
@export var trick_multiplier : PointValue
@export_group("Stats")
@export var stats : Dictionary[Global.StatType, StatValue]

func _ready():
    $GrindingTimer.timeout.connect(on_grinding_timeout)
    for stat in stats.values():
        stat.reset()  # Reset all stats to their initial values when the game starts

# increment a stat via ui
func increment_stat(stat_type: Global.StatType, amount: int) -> void:
    stats[stat_type].increment_by(amount)

# increment grind points while grinding
func increment_grind_points() -> void:
    grind_points.value += stats[Global.StatType.GRIND].value
    calculate_current_score()

func increment_trick_multiplier():
    trick_multiplier.value += 1 
    calculate_current_score()

# calculate the current score based on grind points and trick multiplier
func calculate_current_score() -> int:
    var total_score = grind_points.value + trick_multiplier.value * stats[Global.StatType.TRICK].value
    current_score.value = total_score
    print("current score: ",current_score.value)
    return total_score

func set_grinding(is_grinding: bool) -> void:
    print("set grinding")
    if is_grinding:
        print("starting grinding timer every %f seconds"%(stats[Global.StatType.SPEED].value / 1000.0))
        $GrindingTimer.start(stats[Global.StatType.SPEED].value / 1000.0)  # Convert milliseconds to seconds
    else:
        print("stopping grinding timer")
        $GrindingTimer.stop()
    
func on_grinding_timeout() -> void:
    increment_grind_points()