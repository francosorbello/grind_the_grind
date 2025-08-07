extends StoreButton

@export var speed_stat : StatValue

var _min_reached : bool = false

func _ready() -> void:
    speed_stat.min_reached.connect(_on_min_reached)
    super()

func _on_min_reached():
    _min_reached = true
    button.text = "MAX REACHED"
    button.disabled = true
    pass

func _on_upgrade_incremented():
    if not _min_reached:
        super()

func _process(delta):
    if not _min_reached:
        super(delta)
    

