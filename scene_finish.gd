extends CanvasLayer

const MAP_ONE = "res://map/map_one.tscn"
func set_title(title: String):
	$VBoxContainer/Label.text = title

func _on_button_button_down() -> void:
	get_tree().change_scene_to_file(MAP_ONE)
