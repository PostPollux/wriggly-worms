extends Node

### PRELOAD RESOURCES
var FoodRes = preload("res://Food/GlowingFood.tscn")
var SegmentRes = preload("res://Worms/Segment.tscn")


var points : int = 20

var Game : wriggly_worms


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	randomize() # important so that all random functions give different values on each startup.
	
	# set Game varibale
	Game = get_tree().root.get_node("Game")
	



