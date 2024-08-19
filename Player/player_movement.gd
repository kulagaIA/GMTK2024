extends CharacterBody2D

@export var acceleratin : float = 250
@export var max_speed : float = 200
@export var rotation_speed_degrees : float = 50
@export var drag : float = 150 

var move_direction : Vector2 = Vector2(0,0)
var rotate_target = null

func _physics_process(delta):
	move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#rotate_target = get_global_mouse_position()
	if move_direction != null:
		#var direction : Vector2 = Input.get_vector("left", "right", "up", "down")
		velocity += move_direction * acceleratin * delta
		var velocity_length : float = velocity.length()
		if !is_nan((velocity / velocity_length).x) :
			velocity = velocity - velocity / velocity_length * drag * delta
		if velocity_length > max_speed:
			velocity = velocity / velocity_length * max_speed
	
	if rotate_target != null:
		#var target : Vector2 = get_global_mouse_position()
		var cur_forward : Vector2 = Vector2.from_angle(global_rotation)
		var target_direction : Vector2 = global_position.direction_to(rotate_target)
		var delta_rotation_deg : float = rad_to_deg(cur_forward.angle_to(target_direction))
		var max_rotation_deg : float = rotation_speed_degrees * delta
		delta_rotation_deg = clampf(delta_rotation_deg, -max_rotation_deg, max_rotation_deg)
		global_rotation_degrees += delta_rotation_deg
	
	move_and_slide()
