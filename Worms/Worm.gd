extends Node2D



var worm_points : float = 10
var worm_start_segments : int = 10
var worm_segment_distance : float = 6

var worm_scale : float = 1.0



var LastSegment 
var current_segment_count : int = 0
var current_scale : float = 1.0

onready var Head = $"ActiveHead"
onready var ScaleTween = $"ScaleTween"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LastSegment = Head
	
	for i in range(0, worm_start_segments):
		add_segment()


func eat_points(points : int) -> void:
	
	worm_points += points
	
	worm_scale = 1 + float(worm_points) / 2000
	
	ScaleTween.interpolate_property(self, "current_scale", current_scale, worm_scale,2.0,Tween.TRANS_CUBIC,Tween.EASE_OUT)
	ScaleTween.start()
	
	var needed_segments = (worm_points / 10) / max(worm_scale * 0.5, 1)
	
	if needed_segments > current_segment_count:
		for i in range(0, needed_segments - current_segment_count):
			add_segment()



func add_segment() -> void:
	var Segment = GameManager.SegmentRes.instance()
	
	Segment.Worm = self
	
	if current_segment_count == 0:
		Segment.PreviousSegment = Head
	
	Segment.PreviousSegment = LastSegment
	Segment.rotation = LastSegment.rotation
	Segment.position = LastSegment.position
	Segment.get_node("Sprite").z_index = LastSegment.get_node("Sprite").z_index - 1
	
	self.add_child(Segment)
	
	current_segment_count += 1
	
	LastSegment = Segment
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
