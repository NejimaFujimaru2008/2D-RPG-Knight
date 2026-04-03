extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level1.tscn")

func _on_settings_button_pressed() -> void:
	print("Settings not implemented yet.")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
