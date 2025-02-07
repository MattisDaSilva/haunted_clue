extends Area2D

@export var player_path: NodePath 
@onready var key_sound = preload("res://assets/sounds/key-sound.mp3")
@export var popup_path: NodePath 

var player_in_zone = false 

func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	if body.name == "Player":  
		player_in_zone = true
		$eKeycap.visible = true
		print_debug("Dans la zone")

func _on_body_exited(body):
	if body.name == "Player":
		player_in_zone = false
		$eKeycap.visible = false
		print_debug("Plus dans la zone")

func _process(_delta):
	if player_in_zone and Input.is_action_just_pressed("interact"):
		give_key()

func give_key():
	var player = get_node(player_path) if player_path else null
	if player and player.has_method("_on_key_collected"):
		player._on_key_collected() 
		$starKeyCave.visible = false
		$"../keySound".play()
		player.key += 1
		print_debug("✅ Clé collectée !")
		print_debug("Key", player.key)
		queue_free()
		var popup = get_node(popup_path) if popup_path else null
		if popup:
			popup.show_popup()
		else:
			print_debug("⚠️ ERREUR : Impossible de donner la clé au joueur !")
