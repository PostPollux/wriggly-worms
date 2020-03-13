extends Node2D



var worm_points : float = 10
export var worm_start_segments : int = 10
export var worm_segment_distance : float = 6
export var worm_3d_rotate_effect : bool = true

export var worm_scale : float = 1.0
export var default_speed : float = 3
export var turbo_speed : float = 9
export var acceleration : float = 0.2
export var default_worm_flexibility : float = 5

export var camera_offset : Vector2 = Vector2(0,0)

# Control mode
# player: controlled by you
# lan-player: controlled by someone else
# ai-player: controlled by the computer
# config: the movement the worm makes in the config menu
export var control_mode : String = "player" 


var LastSegment 
var current_segment_count : int = 0
var current_scale : float = 1.0

onready var Head = $"Head"
onready var ScaleTween = $"ScaleTween"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_scale = worm_scale
	LastSegment = Head
	
	for i in range(0, worm_start_segments):
		add_segment()


func eat_points(points : int) -> void:
	
	if control_mode != "config":
		worm_points += points
		
		worm_scale = 1 + float(worm_points) / 3500
		
		ScaleTween.interpolate_property(self, "current_scale", current_scale, worm_scale,2.0,Tween.TRANS_CUBIC,Tween.EASE_OUT)
		ScaleTween.start()
		
		var needed_segments = (worm_points / 10) / max(worm_scale, 1)
		
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
	if control_mode == "config":
		Segment.position = LastSegment.position - Vector2(worm_segment_distance * current_scale ,0)
	else:
		Segment.position = LastSegment.position
	Segment.get_node("Sprite").z_index = LastSegment.get_node("Sprite").z_index - 1
	
	self.add_child(Segment)
	
	current_segment_count += 1
	
	LastSegment = Segment
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
