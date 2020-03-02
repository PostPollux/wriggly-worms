extends Node2D


### PRELOAD RESOURCES
var FoodRes = preload("res://Food/GlowingFood.tscn")

### SIGNALS

### ONREADY VARIABLES

### EXPORTED VARIABLES

### VARIABLES



########## FUNCTIONS ##########


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for i in range(0,200):
		
		var Food = FoodRes.instance()
		Food.position = Vector2(randf() * OS.window_size.x, randf() * OS.window_size.y)
	
		self.add_child(Food)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
