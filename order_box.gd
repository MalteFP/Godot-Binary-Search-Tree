extends Control


var selected = null
var order = ["checkedLeft","checkedRight","checked"]

func on_button_pressed(name: String):
	if selected == null:
		selected = name
	else:
		var aIndex = order.find(name)
		var bIndex = order.find(selected)
		
		var temp = order[aIndex]
		order[aIndex] = order[bIndex]
		order[bIndex] = temp
		
		var a = get_node(name)
		var b = get_node(selected)

		move_child(a, bIndex)
		move_child(b, aIndex)

		selected = null


func get_order():
	var order = []

	for child in get_children():
		order.append(str(child.name))

	return order
	
func _on_button_pressed(extra_arg_0: String):
	on_button_pressed(extra_arg_0)
