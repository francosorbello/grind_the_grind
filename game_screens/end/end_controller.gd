extends Node

@export var game_s : String

@export var score : ScoreValue
@export var score_label : RichTextLabel

func _on_reset_button_pressed() -> void:
    $ClickSound.play()
    IndieBlueprintSceneTransitioner.transition_to(
        game_s,
        IndieBlueprintPremadeTransitions.Voronoi,
        IndieBlueprintPremadeTransitions.Voronoi
    )
    pass # Replace with function body.

func _ready() -> void:
    var cool_score : Big = Big.new(1,6)
    var score_val = ""
    if score.as_big().isGreaterThan(cool_score):
        score_val = score.as_big().toScientific()
    else:
        score_val = str(score.value)
    var score_text : String = "Final Score: [color=FFAAA0]%s [/color] " % score_val
    score_label.bbcode_text = score_text