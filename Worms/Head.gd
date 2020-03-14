extends Node2D

var Worm : Node2D

var current_speed : float = 0
var last_movement_vector : Vector2 
var desired_movement_vector : Vector2 

var running_time : float = 0.0
var drop_time : float = 0.0



onready var camera : Camera2D = $"Camera2D"

signal update_next_segment


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Worm = get_parent()
	current_speed = Worm.default_speed
	camera.offset = Worm.camera_offset



func _process(delta: float) -> void:
	
	if is_instance_valid(Worm):
		
		running_time += delta
		
		match Worm.control_mode:
			
			# controlled by you
			"player":
			
				self.scale = Vector2(Worm.current_scale, Worm.current_scale)
				var cam_zoom : float = 1 + (Worm.current_scale - 1) * 0.2
				camera.zoom = Vector2(cam_zoom, cam_zoom)
				
				if Input.is_action_pressed("turbo") and Worm.worm_points > 0:
					drop_time += delta
					current_speed = min(current_speed + Worm.acceleration, Worm.turbo_speed)
					if drop_time > Worm.turbo_drop_interval:
						drop_time = 0.0
						Worm.drop_food_on_turbo()
				else:
					current_speed = max(current_speed - Worm.acceleration, Worm.default_speed)
				
				
				desired_movement_vector = (get_global_mouse_position() - self.global_position ).normalized()
				
				var calculated_movement_vector : Vector2 = (last_movement_vector + ((Worm.default_worm_flexibility / Worm.current_scale *2) * 0.01  ) * desired_movement_vector).normalized()
				
				last_movement_vector = calculated_movement_vector
				
				self.look_at(self.global_position + calculated_movement_vector)
				self.position += calculated_movement_vector * current_speed * (60 * delta)
				
				emit_signal("update_next_segment", last_movement_vector * -1)
			
			
			# the movement the worm makes in the config menu
			"config":
				
				self.scale = Vector2(Worm.current_scale, Worm.current_scale)
				var cam_zoom : float = 1 + (Worm.current_scale - 1) * 0.2
				camera.zoom = Vector2(cam_zoom, cam_zoom)
				
				current_speed = max(current_speed - Worm.acceleration, Worm.default_speed)
				
				
				desired_movement_vector = (Vector2 (10, sin(running_time * 2) * 4)).normalized()
				
				var calculated_movement_vector : Vector2 = (last_movement_vector + ((Worm.default_worm_flexibility / Worm.current_scale *2) * 0.01  ) * desired_movement_vector).normalized()
				
				last_movement_vector = calculated_movement_vector
				
				self.look_at(self.position + calculated_movement_vector)
				self.position += calculated_movement_vector * current_speed
				
				emit_signal("update_next_segment", last_movement_vector * -1)
		
		


func _on_Area2D_area_entered(area: Area2D) -> void:
	area.get_parent().connect("just_eaten", get_parent(), "eat_points")
