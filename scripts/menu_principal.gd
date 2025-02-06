extends Control

@onready var first_level = preload("res://scenes/house.tscn")
@onready var menu = preload("res://scenes/menu-principal.tscn")
@onready var parametre = preload("res://scenes/parametre.tscn")
@onready var credits = preload("res://scenes/credits.tscn")



func _on_startbtn_button_down() -> void:
	get_tree().change_scene_to_packed(first_level)

func _on_quitbtn_button_down() -> void:
	get_tree().quit()

func _on_menubtn_button_down() -> void:
	get_tree().change_scene_to_packed(menu)
	

func _on_parametre_button_down() -> void:
	get_tree().change_scene_to_packed(parametre)


func _on_credits_button_down() -> void:
	get_tree().change_scene_to_packed(credits)
