extends Node

### PRELOAD RESOURCES
var FoodRes = preload("res://Food/GlowingFood.tscn")
var SegmentRes = preload("res://Worms/Segment.tscn")
var WormRes = preload("res://Worms/Worm.tscn")


var current_points : int = 20
var game_running : bool = false


var own_worm : WW_Worm

var Game : wriggly_worms


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	randomize() # important so that all random functions give different values on each startup.
	
	# set Game varibale
	Game = get_tree().root.get_node("Game")
	
	

func _process(delta: float) -> void:
	if is_instance_valid(own_worm):
		current_points = own_worm.worm_points

