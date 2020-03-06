extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var LastSegment 
var segment_count : int = 0

onready var Head = $"ActiveHead"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LastSegment = Head
	
	for i in range(0, 200):
		add_segment()



	

func add_segment() -> void:
	var Segment = GameManager.SegmentRes.instance()
	
	if segment_count == 0:
		Segment.PreviousSegment = Head
	
	Segment.PreviousSegment = LastSegment
	Segment.rotation = LastSegment.rotation
	Segment.position = LastSegment.position
	Segment.get_node("Sprite").z_index = LastSegment.get_node("Sprite").z_index - 1
	
	self.add_child(Segment)
	
	LastSegment = Segment
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
