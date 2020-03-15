extends Node

class_name wriggly_worms

onready var Map : WW_Map = $"Map"
onready var MainMenu : WW_MainMenu = $"CanvasLayer/GUI/MainMenu"
onready var WormConfigMenu : WW_WormConfigMenu = $"CanvasLayer/GUI/WormConfigMenu"
onready var ConfigWorm : WW_ConfigWorm = $"ConfigWorm"
onready var MusicPlayer : AudioStreamPlayer = $"MusicPlayer"
onready var MusicFadeOutTween : Tween = $"MusicPlayer/MusicFadeOutTween"
onready var MusicFadeInTween : Tween = $"MusicPlayer/MusicFadeInTween"

var Music1 : AudioStream = preload("res://Music/Action Strike.ogg")
var Music2 : AudioStream = preload("res://Music/Bit Bit Loop.ogg")
var Music3 : AudioStream = preload("res://Music/Chronos.ogg")
var Music4 : AudioStream = preload("res://Music/Driving Concern.ogg")

var MusicArray : Array

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
	
	MusicArray.append(Music1)
	MusicArray.append(Music2)
	MusicArray.append(Music3)
	MusicArray.append(Music4)
	
	MusicArray.shuffle()
	
	MusicPlayer.stream = MusicArray[0]
	
	MusicPlayer.play()
	
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
func _process(delta: float) -> void:
	
	# Fade in music at the start of a song
	if MusicPlayer.get_playback_position() < 2:
		MusicPlayer.volume_db = -20 + MusicPlayer.get_playback_position() * 10 
	
	# fade out music at the end of a song
	if MusicPlayer.get_playback_position() >= MusicPlayer.stream.get_length() - 2 :
		MusicPlayer.volume_db = -20 + (MusicPlayer.stream.get_length() - MusicPlayer.get_playback_position()) * 10 
	
	# switch to a random song when song ends
	if MusicPlayer.get_playback_position() >= MusicPlayer.stream.get_length() - 0.2 :
		MusicArray.shuffle()
		MusicPlayer.playing = false
		MusicPlayer.stream = MusicArray[0]
		MusicPlayer.play()






