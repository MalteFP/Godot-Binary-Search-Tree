extends Control


var selected = -1


func on_button_pressed(index):
	if selected == -1:
		selected = index
	else:
		var a = get_child(selected)
		var b = get_child(index)

		move_child(a, index)
		move_child(b, selected)

		selected = -1


func get_order():
	var order = []

	for child in get_children():
		order.append(str(child.name))

	return order
	
func _on_button_pressed(extra_arg_0: int):
	print(extra_arg_0)
	on_button_pressed(extra_arg_0)
