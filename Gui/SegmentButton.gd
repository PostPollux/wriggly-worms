tool

extends TextureButton


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

onready var TextureBox : TextureRect = $"CenterContainer/TextureRect"
onready var HoverTween : Tween = $"HoverTween"

export var SegmentTexture : Texture = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if SegmentTexture != null:
		TextureBox.texture = SegmentTexture
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# this is only to get a preview of the texture in the editor (together with the "tool" keyword)
	if Engine.editor_hint:
		if SegmentTexture != null:
			TextureBox.texture = SegmentTexture


func get_texture() -> Texture:
	return TextureBox.texture


func _on_TextureButton_mouse_entered() -> void:
	HoverTween.interpolate_property(
		TextureBox,
		"rect_scale", 
		TextureBox.rect_scale, 
		Vector2(1.15,1.15), 
		0.25,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT)
	
	HoverTween.start()



func _on_TextureButton_mouse_exited() -> void:
	HoverTween.interpolate_property(
		TextureBox,
		"rect_scale", 
		TextureBox.rect_scale, 
		Vector2(1.0,1.0), 
		0.25,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT)
	
	HoverTween.start()


func _on_SegmentButton_pressed() -> void:
	for i in range(0,50):
		GameManager.Game.visual_worm_config.Segments[i] = TextureBox.texture
	
	# preview
	for Segment in GameManager.Game.ConfigWorm.WormToConfig.Segments:
		Segment.set_segment_texture(TextureBox.texture)
