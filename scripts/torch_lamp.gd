extends Area2D

@export var player_path: NodePath 
@export var popup_path: NodePath 

var player_in_zone = false 

func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)

func _on_body_entered(body):
	if body.name == "Player":  
		player_in_zone = true
		$eKeycap.visible = true
		print_debug("Dans la zone de la lampe")

func _on_body_exited(body):
	if body.name == "Player":
		player_in_zone = false
		$eKeycap.visible = false
		print_debug("Plus dans la zone de la lampe")

func _process(_delta):
	if player_in_zone and Input.is_action_just_pressed("interact"):
		give_lamp()

func give_lamp():
	var player = get_node(player_path) if player_path else null
	if player and player.has_method("_on_lamp_collected"):
		player._on_lamp_collected()  
		$"../LampSound".play()
		$Sprite2D.visible = false 
		$starLamp.visible = false
		print_debug("💡 Lampe collectée !")

		queue_free() 

		var popup = get_node(popup_path) if popup_path else null
		if popup:
			popup.show_popup()
		else:
			print_debug("⚠️ ERREUR : Impossible d'afficher la popup de la lampe !")
