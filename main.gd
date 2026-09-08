extends Node2D

var TreeNodeScene := preload("res://treeNode.tscn")
var root

func create_node(val: int) -> treeNode:
	var node = TreeNodeScene.instantiate()
	node.init(val)
	return node


func binarySearch():
	var searchVal = int(get_node("CanvasLayer/Search/Terms/Search for").text)
	var searching = root
	while searching != null:
		searching.get_node("ColorRect").color = Color(1.0, 1.0, 0.0, 1.0)
		await get_tree().create_timer((float(get_node("CanvasLayer/Search/Terms/Pause Time").text))).timeout
		if searching.value == searchVal:
			searching.get_node("ColorRect").color = Color(0.0, 1.0, 0.0, 1.0)
			break
		elif searchVal < searching.value:
			searching.get_node("ColorRect").color = Color(1.0, 1.0, 1.0, 1.0)
			searching = searching.left
		else:
			searching.get_node("ColorRect").color = Color(1.0, 1.0, 1.0, 1.0)
			searching = searching.right


func christianSearch():
	var order = get_node("CanvasLayer/Search/OrderBox").get_order()
	print(order)
	
	
func clearTree():
	root.queue_free()
	
func addNode():
	if root != null:
		root.addNode(create_node(int(get_node("CanvasLayer/Tree/New node/New Node size").text)))
	else:
		root = create_node(int(get_node("CanvasLayer/Tree/New node/New Node size").text))
		root.name = "root"
		add_child(root)

func randomNodes():
	for i in range(int(get_node("CanvasLayer/Tree/Random Node2/Amount of random nodes").text)):
		if root != null:
			root.addNode(create_node(randf_range(float(get_node("CanvasLayer/Tree/Random Node2/Start Interval").text), float(get_node("CanvasLayer/Tree/Random Node2/End Interval" ).text))))
		else:
			root = create_node(randf_range(float(get_node("CanvasLayer/Tree/Random Node2/Start Interval").text), float(get_node("CanvasLayer/Tree/Random Node2/End Interval" ).text)))
			root.name = "root"
			add_child(root)
		
