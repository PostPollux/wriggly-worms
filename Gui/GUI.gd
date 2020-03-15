extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

onready var MusicOnOffButton : TextureButton = $"MusicOnOffButton"

var musicOffTexture : Texture = preload("res://Gui/Icons/musicOff.png")
var musicOnTexture : Texture = preload("res://Gui/Icons/musicOn.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MusicOnOffButton.modulate = Color(1,1,1,0.3)
	
	#if GameManager.Game.MusicPlayer.playing:
	#	MusicOnOffButton.texture_normal = musicOffTexture
	#else:
	#	MusicOnOffButton.texture_normal = musicOnTexture

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_MusicOnOffButton_mouse_entered() -> void:
	MusicOnOffButton.modulate = Color(1,1,1,1)


func _on_MusicOnOffButton_mouse_exited() -> void:
	MusicOnOffButton.modulate = Color(1,1,1,0.3)


func _on_MusicOnOffButton_pressed() -> void:
	
	if GameManager.Game.MusicPlayer.playing:
		GameManager.Game.fade_out_music()
		MusicOnOffButton.texture_normal = musicOffTexture
	else:
		GameManager.Game.fade_in_music()
		MusicOnOffButton.texture_normal = musicOnTexture
