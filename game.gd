extends Node

class_name wriggly_worms

onready var Map : WW_Map = $"Map"
onready var MainMenu : WW_MainMenu = $"CanvasLayer/GUI/MainMenu"
onready var WormConfigMenu : WW_WormConfigMenu = $"CanvasLayer/GUI/WormConfigMenu"
onready var ConfigWorm : WW_ConfigWorm = $"ConfigWorm"
onready var MusicPlayer : AudioStreamPlayer = $"MusicPlayer"
onready var MusicFadeOutTween : Tween = $"MusicPlayer/MusicFadeOutTween"
onready var MusicFadeInTween : Tween = $"MusicPlayer/MusicFadeInTween"

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


func fade_out_music() -> void:
	MusicFadeOutTween.interpolate_property(
		MusicPlayer,
		"volume_db", 
		0.0, 
		-20.0, 1.0,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT)
	
	MusicFadeOutTween.start()

func _on_MusicFadeOutTween_tween_completed(object: Object, key: NodePath) -> void:
	MusicPlayer.playing = false

func fade_in_music() -> void:
	MusicPlayer.playing = true
	
	MusicFadeInTween.interpolate_property(
		MusicPlayer,
		"volume_db", 
		-20.0, 
		0.0, 1.0,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT)
	
	MusicFadeInTween.start()


	
func back_to_main_menu() -> void:
	MainMenu.visible = true
	
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass






