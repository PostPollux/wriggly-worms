extends Node2D

class_name WWMap

### SIGNALS

### ONREADY VARIABLES
onready var MapSwitcher = $MapSwitcher

### EXPORTED VARIABLES

### VARIABLES

var food_start_amount = 2000
var map_size : int = 5000




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var iterator : int = 0
	
	for i in range(0, food_start_amount):
		
		if iterator == 0:
			add_food_at_random_position_radial_simple()
		else:
			add_food_at_random_position_square()
		
		iterator = (iterator + 1) % 2
		

func next_background() -> void:
	MapSwitcher.activate_next()



# Distribution is not even. There will be more food in the middle then on the periphery 
func add_food_at_random_position_radial_simple():
	
	var Food = GameManager.FoodRes.instance()
	
	var random_direction_vector : Vector2 = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
	
	Food.position = self.position + random_direction_vector * (randf() * (map_size / 2))
	
	self.add_child(Food)


# Even distribution in a square
func add_food_at_random_position_square():
	
	var Food = GameManager.FoodRes.instance()
	
	Food.position = (self.position - Vector2(map_size / 2, map_size / 2)) + Vector2(randi() % map_size, randi() % map_size )
	
	self.add_child(Food)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
