extends Node2D

var TreeNodeScene := preload("res://treeNode.tscn")
var root
var searchVal
func create_node(val: int) -> treeNode:
	var node = TreeNodeScene.instantiate()
	node.init(val)
	return node
func _ready():
	var Bool = true
	if typeof(Bool) == 1:
		print("true")
	else:
		print("false")

func binarySearch():
	searchVal = int(get_node("CanvasLayer/Search/Terms/Search for").text)
	var searching = root
	while searching != null:
		searching.get_node("ColorRect").color = Color(1.0, 1.0, 0.0, 1.0)
		await get_tree().create_timer((float(get_node("CanvasLayer/Search/Terms/Pause Time").text))).timeout
		if searching.value == searchVal:
			searching.get_node("ColorRect").color = Color(0.0, 1.0, 0.0, 1.0)
			get_node("Camera2D").position = searching.global_position
			get_node("Camera2D").zoom = Vector2(1,1)
			break
		elif searchVal < searching.value:
			searching.get_node("ColorRect").color = Color(1.0, 1.0, 1.0, 1.0)
			if searching.right != null:
				searching.right.colorTree(Color(1.0, 0.0, 0.0, 1.0))
			searching = searching.left
		else:
			searching.get_node("ColorRect").color = Color(1.0, 1.0, 1.0, 1.0)
			if searching.left != null:
				searching.left.colorTree(Color(1.0, 0.0, 0.0, 1.0))
			searching = searching.right


func christianSearch():
	var order = get_node("CanvasLayer/Search/OrderBox").get_order()
	searchVal = int(get_node("CanvasLayer/Search/Terms/Search for").text)
	var searching = root

	while searching != null:

		searching.get_node("ColorRect").color = Color(1.0, 1.0, 0.0, 1.0)
		await get_tree().create_timer(float(get_node("CanvasLayer/Search/Terms/Pause Time").text)).timeout
		var actionsFunc = {
			"checkedLeft": left,
			"checkedRight": right,
			"checked": check
		}
		var actionsVar = {
			"checkedLeft": searching.checkedLeft,
			"checkedRight": searching.checkedRight,
			"checked": searching.checked
		}
		var temp = null
		for i in range(3):
			if actionsVar[order[i]] == false:
				temp = actionsFunc[order[i]].call(searching)
				break
		if typeof(temp) == 1:
			if temp == true:
				searching.get_node("ColorRect").color = Color(0.0, 1.0, 0.0, 1.0)
				get_node("Camera2D").position = searching.global_position
				get_node("Camera2D").zoom = Vector2(1,1)
				break
		elif temp == null:
			searching.get_node("ColorRect").color = Color(1.0, 0.0, 0.0, 1.0)
			searching = searching.get_parent()
		
		elif typeof(temp) != 1:
			searching.get_node("ColorRect").color = Color(1.0, 1.0, 1.0, 1.0)
			searching = temp
func left(searching) -> treeNode:
	searching.checkedLeft = true
	if searching.left:
		return searching.left
	else:
		return searching
	
func right(searching) -> treeNode:
	searching.checkedRight = true
	if searching.right:
		return searching.right
	else:
		return searching
	
func check(searching) -> bool:
	searching.checked = true
	if searching.value == searchVal:
		print("Found")
		return true
	return false

func clearTree():
	root.queue_free()

func uncolorTree():
	root.colorTree(Color(1.0, 1.0, 1.0, 1.0))

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
		
func returnToRoot():
	get_node("Camera2D").position = Vector2(0,0)
	get_node("Camera2D").zoom = Vector2(1,1)
	
