extends Control




onready var FPSLabel : Label =$"ColorRect/Label"
onready var points : Label = $"points"


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	FPSLabel.text = String(Engine.get_frames_per_second())
	points.text = String(GameManager.Game.get_node("Worm").worm_points)


func _on_Button_pressed() -> void:
	get_tree().quit()


func _on_Button2_pressed() -> void:
	GameManager.Game.Map.next_background()


func _on_Button3_pressed() -> void:
	GameManager.Game.get_node("Worm/Head/Sprite/DecoSwitcher").activate_next()
