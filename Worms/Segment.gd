extends Node2D

class_name WormSegment

var Worm : Node2D
var PreviousSegment : Node2D
var distance_correct : bool = false

signal update_next_segment


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PreviousSegment.connect("update_next_segment", self, "update_segment")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func update_segment(motion_vec_from_prev_segment):
	
	# set scale
	self.scale = Vector2(Worm.current_scale, Worm.current_scale)
	
	# set rotation
	if Worm.worm_3d_rotate_effect:
		pass # doing nothing to the segment rotation will result in a cool 3d effect
	else:
		self.look_at(PreviousSegment.position)
	
	
	if distance_correct:
		
		var pos_before_moving : Vector2 = self.position
		
		# set position
		var vec_from_prev_segment_to_self : Vector2 = (self.position - PreviousSegment.position )
		
		var new_calculated_dir_vec : Vector2 = (vec_from_prev_segment_to_self + motion_vec_from_prev_segment).normalized()
		self.position = PreviousSegment.position + Worm.worm_segment_distance * Worm.current_scale * new_calculated_dir_vec
		
		emit_signal("update_next_segment", (pos_before_moving - self.position))
		
	else:
		if (PreviousSegment.position - self.position).length() >= Worm.worm_segment_distance * Worm.current_scale:
			distance_correct = true
			
			var pos_before_moving : Vector2 = self.position
		
			# set position
			var vec_from_prev_segment_to_self : Vector2 = (self.position - PreviousSegment.position )
			
			var new_calculated_dir_vec : Vector2 = (vec_from_prev_segment_to_self + motion_vec_from_prev_segment).normalized()
			self.position = PreviousSegment.position + Worm.worm_segment_distance * Worm.current_scale * new_calculated_dir_vec
			
			emit_signal("update_next_segment", (pos_before_moving - self.position))

	
	
	
	
#		if distance_correct:
#
#			# set scale
#			self.scale = Vector2(Worm.current_scale, Worm.current_scale)
#
#			# set position
#			var direction_vector_from_previous_segment_to_self : Vector2 = (self.position - PreviousSegment.position ).normalized()
#			self.position = PreviousSegment.position + Worm.worm_segment_distance * Worm.current_scale * direction_vector_from_previous_segment_to_self
#
#			# set rotation
#			self.look_at(PreviousSegment.position)
#
#			emit_signal("update_next_segment")
#		else:
#			if (PreviousSegment.position - self.position).length() > Worm.worm_segment_distance * Worm.current_scale:
#				distance_correct = true
