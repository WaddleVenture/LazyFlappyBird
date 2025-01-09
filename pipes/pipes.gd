extends Node2D

# Imports
@onready var top_pipe: StaticBody2D = $TopPipe
@onready var color_rect_top: ColorRect =  $TopPipe/ColorRectTop

@onready var bottom_pipe: StaticBody2D = $BottomPipe
@onready var color_rect_bottom: ColorRect = $BottomPipe/ColorRectBottom

@onready var detection_zone: Area2D = $DetectionZone
@onready var detection_shape: CollisionShape2D = $DetectionZone/CollisionShape2D


# Variables
var top_height : float
var bottom_height : float
var detection_height : float
var window_size : Vector2

signal score_zone_passed

# Place the pipes randomly
func random_position():
	# Random height for the detection zone
	detection_height = randf_range(220,400)
	detection_shape.shape.size.y = detection_height
	
	# Place the pipes depending of the detection zone locally
	top_pipe.position.y = - (detection_height / 2) - (top_height / 2)
	bottom_pipe.position.y =  (detection_height / 2) + (bottom_height / 2)
	
	# Random vertical position for the pipes
	position.y = randf_range(detection_height / 2,  window_size.y - (detection_height / 2))


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window_size = get_viewport_rect().size
	
	# Size of the top and bottom pipes
	top_height = color_rect_top.size.y
	bottom_height =  color_rect_bottom.size.y
	
	random_position()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= 200 * delta
	
	if position.x <  - color_rect_top.size.x / 2 :
		position.x = window_size.x + color_rect_top.size.x / 2
		random_position()


func _on_detection_zone_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		emit_signal("score_zone_passed")
 
