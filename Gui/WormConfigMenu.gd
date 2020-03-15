extends Control

class_name WW_WormConfigMenu

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

onready var WWColorPicker : ColorPicker = $"Panel/VBoxContainer/Control/ColorPicker"
onready var HeadDecoColorizationButton = $"Panel/VBoxContainer/HBoxContainer/HeadDecoColorizationButton"
onready var SegmentDecoColorizationButton = $"Panel/VBoxContainer/HBoxContainer2/SegmentDecoColorizationButton"
onready var SegmentDecoSwitcher : NodeSwitcher2D = $"SegmentDecoSwitcher"

var ActiveColorizationButton : Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ActiveColorizationButton = HeadDecoColorizationButton
	self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_BackButton_pressed() -> void:
	GameManager.Game.MainMenu.visible = true
	GameManager.Game.ConfigWorm.hide_config_worm()
	self.visible = false


func _on_NextHeadDecoButton_pressed() -> void:
	# set active Colorization Button and update color picker
	ActiveColorizationButton = HeadDecoColorizationButton
	WWColorPicker.color = ActiveColorizationButton.get_current_color()
	
	# change it here in the preview
	GameManager.Game.ConfigWorm.WormToConfig.Head.HeadDecoSwitcher.activate_next()
	
	# save the config to the "visual_worm_config" Dictionary
	GameManager.Game.visual_worm_config["HeadDeco"] = GameManager.Game.ConfigWorm.WormToConfig.Head.HeadDecoSwitcher.active_node.name
	GameManager.Game.visual_worm_config.colors["HeadDecoColor"] = GameManager.Game.ConfigWorm.WormToConfig.Head.HeadDecoSwitcher.modulate
	


func _on_PrevHeadDecoButton_pressed() -> void:
	# set active Colorization Button and update color picker
	ActiveColorizationButton = HeadDecoColorizationButton
	WWColorPicker.color = ActiveColorizationButton.get_current_color()
	
	# change it here in the preview
	GameManager.Game.ConfigWorm.WormToConfig.Head.HeadDecoSwitcher.activate_previous()
	
	# save the config to the "visual_worm_config" Dictionary
	GameManager.Game.visual_worm_config["HeadDeco"] = GameManager.Game.ConfigWorm.WormToConfig.Head.HeadDecoSwitcher.active_node.name
	GameManager.Game.visual_worm_config.colors["HeadDecoColor"] = GameManager.Game.ConfigWorm.WormToConfig.Head.HeadDecoSwitcher.modulate
	


func _on_PrevSegmentDecoButton_pressed() -> void:
	SegmentDecoSwitcher.activate_previous()
	
	# set active Colorization Button and update color picker
	ActiveColorizationButton = SegmentDecoColorizationButton
	WWColorPicker.color = ActiveColorizationButton.get_current_color()
	
	# change it here in the preview
	if SegmentDecoSwitcher.active_node.texture != null:
		
		# change it here in the preview
		for Segment in GameManager.Game.ConfigWorm.WormToConfig.Segments:
			Segment.set_decoration(SegmentDecoSwitcher.active_node.texture)
			Segment.show_decoration()
			
		# save the config to the "visual_worm_config" Dictionary
		GameManager.Game.visual_worm_config["SegmentDeco"] = SegmentDecoSwitcher.active_node.texture
		
	else:
		
		# change it here in the preview
		for Segment in GameManager.Game.ConfigWorm.WormToConfig.Segments:
			Segment.hide_decoration()
		
		# save the config to the "visual_worm_config" Dictionary
		GameManager.Game.visual_worm_config["SegmentDeco"] = null
		


func _on_NextSegmentDecoButton_pressed() -> void:
	SegmentDecoSwitcher.activate_next()
	
	# set active Colorization Button and update color picker
	ActiveColorizationButton = SegmentDecoColorizationButton
	WWColorPicker.color = ActiveColorizationButton.get_current_color()
	
	
	if SegmentDecoSwitcher.active_node.texture != null:
		
		# change it here in the preview
		for Segment in GameManager.Game.ConfigWorm.WormToConfig.Segments:
			Segment.set_decoration(SegmentDecoSwitcher.active_node.texture)
			Segment.show_decoration()
		
		# save the config to the "visual_worm_config" Dictionary
		GameManager.Game.visual_worm_config["SegmentDeco"] = SegmentDecoSwitcher.active_node.texture
		
		
	else:
		
		# change it here in the preview
		for Segment in GameManager.Game.ConfigWorm.WormToConfig.Segments:
			Segment.hide_decoration()
		
		# save the config to the "visual_worm_config" Dictionary
		GameManager.Game.visual_worm_config["SegmentDeco"] = null


func _on_HeadDecoColorizationButton_ColorizationButtonPressed(ColorizationButton) -> void:
	WWColorPicker.color = ColorizationButton.get_current_color()
	ActiveColorizationButton = ColorizationButton

func _on_SegmentDecoColorizationButton_ColorizationButtonPressed(ColorizationButton) -> void:
	WWColorPicker.color = ColorizationButton.get_current_color()
	ActiveColorizationButton = ColorizationButton


func _on_ColorPicker_color_changed(color: Color) -> void:
	ActiveColorizationButton.set_current_color(color)
	
	match ActiveColorizationButton.color_string:
		"HeadDecoColor" :
			GameManager.Game.ConfigWorm.WormToConfig.Head.HeadDecoSwitcher.modulate = color
			GameManager.Game.visual_worm_config.colors["HeadDecoColor"] = color
		"SegmentDecoColor" :
			for Segment in GameManager.Game.ConfigWorm.WormToConfig.Segments:
				Segment.tint_decoration(color)
			GameManager.Game.visual_worm_config.colors["SegmentDecoColor"] = color











