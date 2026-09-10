extends Node2D

var TreeNodeScene := preload("res://treeNode.tscn")
var root
var searchVal
func create_node(val: float) -> treeNode:
	var node = TreeNodeScene.instantiate()
	node.init(val)
	return node


func binarySearch():
	searchVal = float(get_node("CanvasLayer/Search/Terms/Search for").text)
	print(searchVal)
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
			searching.get_node("ColorRect").color = Color(1.0, 0.0, 0.0, 1.0)
			if searching.right != null:
				searching.right.colorTree(Color(1.0, 0.0, 0.0, 1.0))
			searching = searching.left
		else:
			searching.get_node("ColorRect").color = Color(1.0, 0.0, 0.0, 1.0)
			if searching.left != null:
				searching.left.colorTree(Color(1.0, 0.0, 0.0, 1.0))
			searching = searching.right


func christianSearch():
	var order = get_node("CanvasLayer/Search/OrderBox").get_order()
	searchVal = float(get_node("CanvasLayer/Search/Terms/Search for").text)
	var searching = root
	
	var actionsFunc = {
			"checkedLeft": left,
			"checkedRight": right,
			"checked": check
		}
	
	while searching != null:
		var rect = searching.get_node("ColorRect")
		rect.color = Color(1.0, 1.0, 0.0, 1.0)
		await get_tree().create_timer(float(get_node("CanvasLayer/Search/Terms/Pause Time").text)).timeout
		

		var temp = null
		for i in range(3):
			var key = order[i]
			if not searching.get(key):
				temp = actionsFunc[order[i]].call(searching)
				break
		if typeof(temp) == 1:
			if temp == true:
				rect.color = Color(0.0, 1.0, 0.0, 1.0)
				get_node("Camera2D").position = searching.global_position
				get_node("Camera2D").zoom = Vector2(1,1)
				break
		elif temp == null:
			rect.color = Color(1.0, 0.0, 0.0, 1.0)
			if searching.name == &"root":
				break
			searching = searching.get_parent()
		
		elif typeof(temp) != 1:
			rect.color = Color(1.0, 1.0, 1.0, 1.0)
			searching = temp
	if root != null:
		root.resetAllActions()


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
		return true
	return false

func clearTree():
	if root != null:
		root.queue_free()

func uncolorTree():
	if root != null:
		root.colorTree(Color(1.0, 1.0, 1.0, 1.0))

func addNode():
	if root != null:
		root.addNode(create_node(float(get_node("CanvasLayer/Tree/New node/New Node size").text)))
	else:
		root = create_node(float(get_node("CanvasLayer/Tree/New node/New Node size").text))
		root.name = "root"
		add_child(root)

func randomNodes():
	for i in range(float(get_node("CanvasLayer/Tree/Random Node2/Amount of random nodes").text)):
		if root != null:
			root.addNode(create_node(int(randf_range(float(get_node("CanvasLayer/Tree/Random Node2/Start Interval").text), float(get_node("CanvasLayer/Tree/Random Node2/End Interval" ).text)))))
		else:
			root = create_node(int(randf_range(float(get_node("CanvasLayer/Tree/Random Node2/Start Interval").text), float(get_node("CanvasLayer/Tree/Random Node2/End Interval" ).text))))
			root.name = "root"
			add_child(root)
		
func returnToRoot():
	get_node("Camera2D").position = Vector2(0,0)
	get_node("Camera2D").zoom = Vector2(1,1)



func addMultiableNodes() -> void:
	var text = str(get_node("CanvasLayer/Tree/VBoxContainer/Mulitable nodes").text)
	var nums = text.split(", ")
	for num in nums:
		print(num)
		print(float(num))
		if root != null:
			root.addNode(create_node(float(num)))
		else:
			root = create_node(float(num))
			root.name = "root"
			add_child(root)
