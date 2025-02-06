extends Area2D

@export var player_path: NodePath
var player_in_zone = false 

func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	if body.name == "Player":  
		player_in_zone = true
		print_debug("Dans la zone")
		$"../eKeycap".visible = true


func _on_body_exited(body):
	if body.name == "Player":
		player_in_zone = false
		print_debug("Plus dans la zone")
		$"../eKeycap".visible = false

func _process(_delta):
	if player_in_zone and Input.is_action_just_pressed("interact"):
		give_key()

func give_key():
	var player = get_node(player_path) if player_path else null
	if player and player.has_method("_on_key_collected"):
		player._on_key_collected() 
		print_debug("✅ Clé collectée !")
		print_debug(player.key)
		queue_free()
	else:
		print_debug("⚠️ ERREUR : Impossible de donner la clé au joueur !")
