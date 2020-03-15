extends Button


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

signal ColorizationButtonPressed

# this is the name of the key in the "visual_worm_config" Dictionary
export var color_string : String = ""

onready var ColorBox : ColorRect = $"ColorRect"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func set_current_color(color : Color) -> void:
	ColorBox.color = color

func get_current_color() -> Color:
	return ColorBox.color

func _on_ColorizationButton_pressed() -> void:
	emit_signal("ColorizationButtonPressed", self)
