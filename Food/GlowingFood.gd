tool

extends Node2D


onready var FoodSprite : Sprite = $"Sprite"
onready var FoodTween : Tween = $"Tween"
onready var FoodCollider : Area2D =$"Area2D"

var points : int = 1


signal just_eaten

func _ready() -> void:
	
	var FoodMaterial : Material = FoodSprite.get_material()
	
	# apply random points, color and seed
	FoodMaterial.set_shader_param("seed", randf()*100)
	FoodMaterial.set_shader_param("color", Vector3(randf(), randf(), randf()))
	points = randi() % 10 +1
	
	self.scale = Vector2( 1 + points * 0.1, 1 + points * 0.1)
	# set visual movement speed
	FoodMaterial.set_shader_param("speed", 2.0)
	
	


func eat() -> void:
	emit_signal("just_eaten", points)
	self.queue_free()


func _on_Area2D_area_entered(area: Area2D) -> void:
	
	# Make sure that the collider does not fire again
	FoodCollider.set_deferred("monitoring",false)
	
	
	var SnakeHeadArea2D : Area2D = area
	
	# define tweens
	FoodTween.interpolate_property(
		self,
		"scale", 
		self.get_scale(), 
		Vector2(0.4, 0.4), 0.3,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN)
	
	FoodTween.follow_property(
		self, 
		"global_position", 
		self.get_position(), 
		SnakeHeadArea2D, 
		"global_position", 
		0.4,
		Tween.TRANS_CUBIC,
		Tween.EASE_OUT)
	
	# start tween
	FoodTween.start()



func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	eat()
