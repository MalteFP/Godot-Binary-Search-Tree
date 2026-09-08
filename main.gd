extends Node2D

var TreeNodeScene := preload("res://treeNode.tscn")

func _ready() -> void:
	var root = create_node(12)
	add_child(root)
	root.addNode(create_node(12))
	root.addNode(create_node(3))
	root.addNode(create_node(6))
	root.addNode(create_node(13))
	root.addNode(create_node(12))
	root.addNode(create_node(86))
	root.addNode(create_node(52))
	root.addNode(create_node(31))
	root.addNode(create_node(63))
	root.addNode(create_node(123))
	root.addNode(create_node(132))
	root.addNode(create_node(816))
	
	
	var searchVal = 816
	var searching = root

	while searching != null:
		if searching.value == searchVal:
			searching.get_node("ColorRect").color = Color(0.0, 1.0, 0.0, 1.0)
			break
		elif searchVal < searching.value:
			searching = searching.left
		else:
			searching = searching.right


func create_node(val: int) -> treeNode:
	var node = TreeNodeScene.instantiate()
	node.init(val)
	return node
