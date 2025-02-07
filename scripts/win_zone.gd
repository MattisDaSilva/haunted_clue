extends Area2D

@export var win_scene: String = "res://scenes/win.tscn" 

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":  
		print_debug("🎉 Victoire ! Changement de scène...")
		call_deferred("change_scene") 

func change_scene():
	get_tree().change_scene_to_file(win_scene) 
