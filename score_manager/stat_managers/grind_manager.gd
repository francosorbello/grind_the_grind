extends Node

# linear increment of 1
func increment(score_manager : ScoreManager):
    score_manager.increment_stat(Global.StatType.GRIND, 1)
