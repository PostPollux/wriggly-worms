extends Node2D

class_name NodeSwitcher2D

var active_node : Node2D
var active_node_index : int = 0


func _ready() -> void:
	
	for child in self.get_children():
		child.visible = false
		
	set_active_node_by_id(0)




func set_active_node_by_id(id : int) -> void:
	
	var tmp_id : int = max(min(id, self.get_child_count()), 0)
	
	var iterator : int = 0
	
	for child in self.get_children():
		if iterator == tmp_id:
			child.visible = true
			active_node_index = tmp_id
			active_node = child
		else:
			child.visible = false
		
		iterator += 1




func set_active_node(node : Node2D) -> void:
	
	var iterator : int = 0
	
	for child in self.get_children():
		if child == node:
			child.visible = true
			active_node = child
			active_node_index = iterator
		else:
			child.visible = false
		
		iterator += 1



func activate_next() -> void:
	if active_node_index + 1 < self.get_child_count():
		set_active_node_by_id(active_node_index + 1)
	else:
		set_active_node_by_id(0)



func activate_previous() -> void:
	if active_node_index - 1 >= 0:
		set_active_node_by_id(active_node_index - 1)
	else:
		set_active_node_by_id(self.get_child_count() - 1)



func get_active_node() -> Node2D:
	return active_node



func get_active_node_index() -> int:
	return active_node_index


