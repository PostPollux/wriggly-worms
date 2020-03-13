extends Node

class_name wriggly_worms

onready var Map : WWMap = $"Map"
onready var MainMenu : WWMainMenu = $"CanvasLayer/GUI/MainMenu"
onready var WormConfigMenu : WWWormConfigMenu = $"CanvasLayer/GUI/WormConfigMenu"
onready var ConfigWorm : WWConfigWorm = $"ConfigWorm"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func back_to_main_menu() -> void:
	MainMenu.visible = true
	
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
