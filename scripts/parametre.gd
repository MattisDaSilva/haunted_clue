extends Control

@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")

@onready var click_sound_player = $AudioStreamPlayer  # Récupère l'AudioStreamPlayer
@onready var click_sound = preload("res://assets/sounds/btn-sfx.mp3")  # Charge le son
func _play_click_sound() -> void:
	if click_sound_player and not click_sound_player.playing:
		click_sound_player.stream = click_sound  # Assigne le son
		click_sound_player.play()  # Joue le son


func _on_musicslider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < 0.01)  # Mute si volume proche de 0pri
	
func _on_sf_xslider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.01)  # Mute si volume proche de 0

func _on_retourbtn_button_down() -> void:
	_play_click_sound()
	await click_sound_player.finished
	get_tree().change_scene_to_file("res://scenes/menu-principal.tscn")  # Retour au menu
