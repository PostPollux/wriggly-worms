extends Control

class_name WWMainMenu

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Play_Button_pressed() -> void:
	GameManager.game_running = true
	GameManager.Game.Map.generate_initial_food(1000)
	GameManager.Game.Map.add_worm_at_random_position()
	
	self.visible = false


func _on_Exit_Button_pressed() -> void:
	get_tree().quit()


func _on_Config_Button_pressed() -> void:
	GameManager.Game.WormConfigMenu.visible = true
	GameManager.Game.ConfigWorm.show_config_worm()
	
	self.visible = false
