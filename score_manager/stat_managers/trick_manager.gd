extends Node

# linear increment of 10
func increment(score_manager: ScoreManager) -> void:
    score_manager.increment_stat(Global.StatType.TRICK, 10)
