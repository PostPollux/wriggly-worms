extends Control




onready var FPSLabel : Label =$"ColorRect/Label"
onready var points : Label = $"points"
onready var custom_print : Label = $"custom print"
onready var custom_print2 : Label = $"custom print2"


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	FPSLabel.text = String(Engine.get_frames_per_second())
	points.text = String(GameManager.current_points)
	
	#custom_print.text = String( GameManager.Game.MusicPlayer.volume_db )
	#custom_print2.text = String( GameManager.Game.MusicPlayer.get_playback_position() )

func _on_Button_pressed() -> void:
	get_tree().quit()


func _on_Button2_pressed() -> void:
	GameManager.Game.Map.next_background()

