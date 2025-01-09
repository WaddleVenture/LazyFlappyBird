extends CharacterBody2D

@export var data: PlayerResource 
@onready var color_rect: ColorRect = $ColorRect

var window_height : float
var player_height : float

func _ready() -> void:
	window_height = get_viewport_rect().size.y
	player_height = color_rect.size.y
	
	
func _physics_process(delta: float) -> void:
	# Always apply gravity
	velocity += get_gravity() * delta

	#If the player press space he goes up
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = data.jump_velocity
	
	position.y = clamp(position.y, -player_height, window_height + player_height)
	
	# Using move_and_slide.
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision : 
			get_tree().reload_current_scene()
