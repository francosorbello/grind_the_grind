extends AudioStreamPlayer

@export var max_volume: float = 5.0

var min_volume: float = -5.0

func play_wind(time : float):
    volume_db = min_volume
    play()
    var tween := create_tween()
    tween.set_trans(Tween.TRANS_LINEAR)
    tween.tween_property(self, "volume_db", max_volume, time)
    tween.tween_property(self, "volume_db", -80.0, 0.7)
    # tween.chain()