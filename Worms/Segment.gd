extends Node2D

class_name WormSegment

var Head
var PreviousSegment : Node2D
var distance_correct : bool = false
var distance : float = 8


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if is_instance_valid(PreviousSegment):
		if distance_correct:
			self.position = PreviousSegment.position + distance * (self.position - PreviousSegment.position ).normalized()
			self.look_at(PreviousSegment.position)
		else:
			if (PreviousSegment.position - self.position).length() > distance:
				distance_correct = true
