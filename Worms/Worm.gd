extends Node2D



var worm_points : float = 0
export var worm_start_segments : int = 15
export var worm_segment_distance : float = 6
export var worm_3d_rotate_effect : bool = true

export var worm_scale : float = 1.0
export var default_speed : float = 3
export var turbo_speed : float = 9
export var acceleration : float = 0.2
export var default_worm_flexibility : float = 5
export var turbo_drop_interval : float = 0.2

export var camera_offset : Vector2 = Vector2(0,0)

signal just_died

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
	
	if control_mode == "player":
		GameManager.own_worm = self
	
	for i in range(0, worm_start_segments):
		add_segment()


func eat_points(points : int) -> void:
	
	worm_points += points
	
	worm_scale = 1 + float(worm_points) / 3500
	
	ScaleTween.interpolate_property(self, "current_scale", current_scale, worm_scale,2.0,Tween.TRANS_CUBIC,Tween.EASE_OUT)
	ScaleTween.start()
	
	var needed_segments = (worm_points / 10) / max(worm_scale, 1)
	
	if needed_segments + worm_start_segments > current_segment_count :
		add_segment()


func drop_food_on_turbo() -> void:
	var food_value : int = int(worm_scale)
	worm_points -= food_value
	GameManager.Game.Map.add_food_at_position(food_value, LastSegment.global_position)
	
	var needed_segments = (worm_points /10) / max(worm_scale, 1)
	
	if current_segment_count > needed_segments + worm_start_segments:
		var SegmentToDelete = LastSegment
		LastSegment = LastSegment.PreviousSegment
		current_segment_count -= 1
		SegmentToDelete.queue_free()



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
	





func die() -> void:
	emit_signal("just_died")
	self.queue_free()
