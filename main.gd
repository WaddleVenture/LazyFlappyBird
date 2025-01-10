extends Node2D

@onready var score: Label = $HUD/Score
const PIPES = preload("res://pipes/pipes.tscn")

var s = 0

func _on_pipes_score_zone_passed() -> void:
	s += 1
	score.text = str(s)

func _ready() -> void:
	var start_x = 1000
	var spacing_x = 300

	for i in range(4):
		var pipe_instance = PIPES.instantiate()
		pipe_instance.position = Vector2(start_x + i * spacing_x, 0)
		add_child(pipe_instance)
		# Connect the signal emitted by pipes
		if pipe_instance.has_signal("score_zone_passed"):
			pipe_instance.connect("score_zone_passed", _on_pipes_score_zone_passed)
