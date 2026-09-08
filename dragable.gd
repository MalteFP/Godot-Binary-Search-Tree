extends Panel

func get_drag_data(_pos):
	var preview = duplicate()
	preview.modulate = Color(1, 1, 1, 0.5)
	set_drag_preview(preview)
	return self

func can_drop_data(_pos, data):
	return data is Panel

func drop_data(_pos, data):
	var parent = get_parent()
	parent.move_child(data, get_index())
