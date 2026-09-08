extends Control


var selected = -1


func on_button_pressed(index):
	if selected == -1:
		# First object selected
		selected = index
	else:
		# Second object selected -> swap them
		var children = get_children()

		var temp = children[selected]
		children[selected] = children[index]
		children[index] = temp

		# Actually change their positions in the HBoxContainer
		move_child(children[selected], selected)
		move_child(children[index], index)

		selected = -1


func get_order():
	var order = []

	for child in get_children():
		order.append(child.name)

	return order
	
func _on_button_pressed(extra_arg_0: int):
	print(extra_arg_0)
	on_button_pressed(extra_arg_0)
