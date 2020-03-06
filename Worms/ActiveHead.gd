extends Node2D

var Worm : Node2D

var current_speed : float = 0
var default_speed : float = 3
var turbo_speed : float = 9
var acceleration : float = 0.2
var default_worm_flexibility : float = 5
var last_movement_vector = Vector2()
var desired_movement_vector = Vector2()

onready var camera : Camera2D = $"Camera2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Worm = get_parent()
	current_speed = default_speed
	pass # Replace with function body.



func _process(delta: float) -> void:
	
	if is_instance_valid(Worm):
		
		self.scale = Vector2(Worm.current_scale, Worm.current_scale)
		var cam_zoom : float = 1 + (Worm.current_scale - 1) * 0.2
		camera.zoom = Vector2(cam_zoom, cam_zoom)
		
		if Input.is_action_pressed("turbo"):
			current_speed = min(current_speed + acceleration, turbo_speed)
		else:
			current_speed = max(current_speed - acceleration, default_speed)
		
		
		desired_movement_vector = (get_global_mouse_position() - self.position ).normalized()
		
		var calculated_movement_vector : Vector2 = (last_movement_vector + ((default_worm_flexibility / Worm.current_scale *2) * 0.01  ) * desired_movement_vector).normalized()
		
		last_movement_vector = calculated_movement_vector
		
		self.look_at(self.position + calculated_movement_vector)
		self.position += calculated_movement_vector * current_speed
	


func _on_Area2D_area_entered(area: Area2D) -> void:
	area.get_parent().connect("just_eaten", get_parent(), "eat_points")
