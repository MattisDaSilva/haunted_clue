extends Control

@onready var first_level = preload("res://scenes/house.tscn")
@onready var menu = preload("res://scenes/menu-principal.tscn")


func _on_startbtn_button_down() -> void:
	get_tree().change_scene_to_packed(first_level)


func _on_menubtn_button_down() -> void:
		get_tree().change_scene_to_packed(menu)
	


func _on_parametre_button_down() -> void:
	pass # Replace with function body.
