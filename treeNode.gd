extends Node2D
class_name treeNode

var value = null
var right = null
var left = null


func init(value: int):
	self.value = value
	self.get_node("ColorRect/Label").text = str(value)


func addNode(newNode: treeNode):
	print(newNode.value)
	if newNode.value < value:
		if left == null:
			left = newNode
			newNode.name = "left"
			add_child(newNode)
			newNode.position = Vector2(-25,50)
		else:
			left.addNode(newNode)
	else:
		if right == null:
			right = newNode
			newNode.name = "right"
			add_child(newNode)
			newNode.position = Vector2(25,50)
		else:
			right.addNode(newNode)
