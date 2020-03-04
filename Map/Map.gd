extends Node2D

class_name WWMap

### PRELOAD RESOURCES
var FoodRes = preload("res://Food/GlowingFood.tscn")

### SIGNALS

### ONREADY VARIABLES
onready var MapSwitcher = $MapSwitcher

### EXPORTED VARIABLES

### VARIABLES



# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var food_spawn_radius : float = 5000




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for i in range(0,1000):
		
		add_food_at_random_position()


func next_background() -> void:
	MapSwitcher.activate_next()




func add_food_at_random_position():
	
	var Food = FoodRes.instance()
	
	var random_direction_vector : Vector2 = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
	
	Food.position = self.position + random_direction_vector * (randf() * food_spawn_radius)
	
	self.add_child(Food)
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
