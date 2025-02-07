extends Area2D

@export var player_path: NodePath 
@onready var key_sound = preload("res://assets/sounds/key-sound.mp3")
@export var popup_path: NodePath 
@export var popup2_path: NodePath 
var is_locked = true

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
		try_to_open()

func try_to_open():
	var player = get_node(player_path) if player_path else null
	if player:
		if is_locked and player.key > 0:
			player.key -= 1
			is_locked = false  
			print_debug("🔓 Porte ouverte ! Clé utilisée.")
			print_debug("🔑 Clés restantes :", player.key)
			player.update_inventory()
			
			# Jouer le son d'ouverture
			if $AudioStreamPlayer2DDoor:
				$AudioStreamPlayer2DDoor.play()
			
			# Supprimer la collision et cacher la porte
			if $CollisionShape2D:
				$CollisionShape2D.queue_free()
			if $Sprite2D:
				$Sprite2D.visible = false  
			if $LightOccluderGarageDoor:
				$LightOccluderGarageDoor.queue_free()
			if $StaticBody2D and $StaticBody2D.has_node("CollisionShape2D"):
				$StaticBody2D.get_node("CollisionShape2D").queue_free()

			# Afficher une popup si elle est disponible
			if popup_path:
				var popup = get_node(popup_path) if popup_path else null
				if popup:
					popup.show_popup()
		
		elif is_locked:
			print_debug("🚪 La porte est verrouillée !")

			if popup2_path:
				var popup2 = get_node(popup2_path) if popup2_path else null
				if popup2:
					$AudioStreamPlayer2DDoorLocked.play()
					popup2.show_popup()
		else:
			print_debug("🚪 La porte est déjà ouverte.")
