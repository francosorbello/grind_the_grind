extends Node

# linear decrement of 10 ms 
func increment(score_manager: ScoreManager) -> void:
    score_manager.decrement_stat(Global.StatType.SPEED, 10)