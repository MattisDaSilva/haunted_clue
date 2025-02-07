extends Control
@onready var menu = preload("res://scenes/menu-principal.tscn")


@onready var click_sound_player = $AudioStreamPlayer  # Récupère l'AudioStreamPlayer
@onready var click_sound = preload("res://assets/sounds/btn-sfx.mp3")  # Charge le son

func _play_click_sound() -> void:
	if click_sound_player and not click_sound_player.playing:
		click_sound_player.stream = click_sound  # Assigne le son
		click_sound_player.play()  # Joue le son

func _on_winmenubtn_button_down() -> void:
	_play_click_sound()
	await click_sound_player.finished
	get_tree().change_scene_to_packed(menu)


func _on_winquitterbtn_button_down() -> void:
	_play_click_sound()
	await click_sound_player.finished
	get_tree().quit()
