extends Node2D

class_name WormSegment

var Worm : Node2D
var PreviousSegment : Node2D
var distance_correct : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if is_instance_valid(PreviousSegment):
		if distance_correct:
			self.scale = Vector2(Worm.current_scale, Worm.current_scale)
			self.position = PreviousSegment.position + Worm.worm_segment_distance * Worm.current_scale * (self.position - PreviousSegment.position ).normalized()
			self.look_at(PreviousSegment.position)
		else:
			if (PreviousSegment.position - self.position).length() > Worm.worm_segment_distance * Worm.current_scale:
				distance_correct = true
