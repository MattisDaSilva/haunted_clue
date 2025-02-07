extends Control

@onready var first_level = preload("res://scenes/house.tscn")
@onready var menu = preload("res://scenes/menu-principal.tscn")
@onready var parametre = preload("res://scenes/parametre.tscn")
@onready var credits = preload("res://scenes/credits.tscn")

@onready var click_sound_player = $AudioStreamPlayer  # Récupère l'AudioStreamPlayer
@onready var click_sound = preload("res://assets/sounds/btn-sfx.mp3")  # Charge le son

func _play_click_sound() -> void:
	if click_sound_player and not click_sound_player.playing:
		click_sound_player.stream = click_sound  # Assigne le son
		click_sound_player.play()  # Joue le son

func _on_startbtn_button_down() -> void:
	_play_click_sound()
	await click_sound_player.finished  # Attend la fin du son
	get_tree().change_scene_to_packed(first_level)

func _on_quitbtn_button_down() -> void:
	_play_click_sound()
	await click_sound_player.finished
	get_tree().quit()

func _on_menubtn_button_down() -> void:
	_play_click_sound()
	await click_sound_player.finished
	get_tree().change_scene_to_packed(menu)

func _on_parametre_button_down() -> void:
	_play_click_sound()
	await click_sound_player.finished
	get_tree().change_scene_to_packed(parametre)

func _on_credits_button_down() -> void:
	_play_click_sound()
	await click_sound_player.finished
	get_tree().change_scene_to_packed(credits)
