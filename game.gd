extends Node

class_name wriggly_worms

onready var Map : WW_Map = $"Map"
onready var MainMenu : WW_MainMenu = $"CanvasLayer/GUI/MainMenu"
onready var WormConfigMenu : WW_WormConfigMenu = $"CanvasLayer/GUI/WormConfigMenu"
onready var ConfigWorm : WW_ConfigWorm = $"ConfigWorm"


var visual_worm_config : Dictionary = {
	"HeadDeco" : "none",
	"SegmentDeco" : null,
	"colors" : {
		"HeadDecoColor" : Color(1,1,1,1),
		"SegmentDecoColor" : Color(1,1,1,1)
	}
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func back_to_main_menu() -> void:
	MainMenu.visible = true
	
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
