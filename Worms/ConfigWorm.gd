extends Node2D

class_name WWConfigWorm

onready var WormToConfig = $"Worm"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# remove the worm so it does not use any processing power
	self.remove_child(WormToConfig)


func show_worm() -> void:
	self.add_child(WormToConfig)
	

func hide_config_worm() -> void:
	self.remove_child(WormToConfig)
