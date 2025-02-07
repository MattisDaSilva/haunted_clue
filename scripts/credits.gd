extends Control

@onready var click_sound_player = $AudioStreamPlayer 
@onready var click_sound = preload("res://assets/sounds/btn-sfx.mp3")  
func _play_click_sound() -> void:
	if click_sound_player and not click_sound_player.playing:
		click_sound_player.stream = click_sound  
		click_sound_player.play()  

func _on_retourcreditsbtn_button_down() -> void :
	_play_click_sound()
	await click_sound_player.finished
	get_tree().change_scene_to_file("res://scenes/menu-principal.tscn") 
