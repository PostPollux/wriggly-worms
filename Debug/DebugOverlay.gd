extends Control




onready var FPSLabel : Label =$"ColorRect/Label"


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	FPSLabel.text = String(Engine.get_frames_per_second())


func _on_Button_pressed() -> void:
	get_tree().quit()


func _on_Button2_pressed() -> void:
	GameManager.Game.Map.next_background()
