extends Node2D

@onready var score: Label = $HUD/Score

var s = 0

func _on_pipes_score_zone_passed() -> void:
	s += 1
	score.text = str(s)
