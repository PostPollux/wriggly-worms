extends Control

class_name WWWormConfigMenu

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_BackButton_pressed() -> void:
	GameManager.Game.MainMenu.visible = true
	GameManager.Game.ConfigWorm.hide_config_worm()
	self.visible = false
