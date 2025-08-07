extends Node

@export var game_s : String

@export var score : ScoreValue
@export var score_label : RichTextLabel
@export var nan_label : RichTextLabel

func _on_reset_button_pressed() -> void:
    $ClickSound.play()
    IndieBlueprintSceneTransitioner.transition_to(
        game_s,
        IndieBlueprintPremadeTransitions.Voronoi,
        IndieBlueprintPremadeTransitions.Voronoi
    )
    pass # Replace with function body.

func _ready() -> void:
    var score_val = ""
    if score.value == -1:
        score_val = "NaN"
        nan_label.visible = true
    else:    
        score_val = score.as_big().toMetricSymbol(true)
    var score_text : String = "Final Score: [color=FFAAA0]%s [/color] " % score_val
    score_label.bbcode_text = score_text