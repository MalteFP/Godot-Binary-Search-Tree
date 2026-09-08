extends Node2D
class_name treeNode

var value = null
var right = null
var left = null
var index = null

var checkedRight = false
var checkedLeft = false
var checked = false



func init(value: int, index := 0):
	self.value = value
	self.index = index
	self.get_node("ColorRect/Label").text = str(value)


func addNode(newNode: treeNode, depth := 1):
	var size = 50
	if newNode.value < value:
		if left == null:
			left = newNode
			if index == 0:
				newNode.index = -1
			else:
				newNode.index = index * 2
				if newNode.index > 0:
					newNode.index -= sign(newNode.index)
			
			var pos = Vector2((newNode.index * size) - sign(index) * 17.5,size*depth)
			newNode.global_position = pos
			add_child(newNode)
			
			var line = Line2D.new()
			add_child(line)
			line.width = 1
			line.default_color = Color(0.0, 0.0, 1.0, 1.0)
			var p1 = line.to_local(global_position + Vector2(-10,20))
			var p2 = line.to_local(newNode.global_position + Vector2(0,-20))
			line.points = [p1, p2] 


		else:
			left.addNode(newNode, depth + 1)
	else:
		if right == null:
			right = newNode
			if index == 0:
				newNode.index = 1
			else:
				newNode.index = index * 2
				if newNode.index < 0:
					newNode.index -= sign(newNode.index)
			var pos = Vector2((newNode.index * size) - sign(index) * 17.5,size*depth)
			newNode.global_position = pos
			add_child(newNode)
			
			var line = Line2D.new()
			add_child(line)
			line.width = 1
			line.default_color = Color(1.0, 0.0, 0.0, 1.0)
			var p1 = line.to_local(global_position + Vector2(10,20))
			var p2 = line.to_local(newNode.global_position + Vector2(0,-20))
			line.points = [p1, p2]  
		else:
			right.addNode(newNode, depth + 1)



func clearTree():
	if right != null:
		right.clearTree()
	if left != null:
		left.clearTree()
	
	right == null
	left == null

func colorTree(color: Color):
	if right != null:
		right.colorTree(color)
		right.get_node("ColorRect").color = color
	if left != null:
		left.colorTree(color)
		left.get_node("ColorRect").color = color
	
