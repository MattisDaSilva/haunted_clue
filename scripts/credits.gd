extends Control

func _on_retourcreditsbtn_button_down() -> void :
	get_tree().change_scene_to_file("res://scenes/menu-principal.tscn")  # Retour au menu
