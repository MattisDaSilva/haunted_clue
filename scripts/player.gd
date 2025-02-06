extends CharacterBody2D

@export var speed: float = 55
@export var maxHealth: int = 3
@onready var currentHealth: int = maxHealth
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

var last_direction := Vector2.LEFT

func _physics_process(_delta):
	var direction = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	if direction != Vector2.ZERO:
		direction = direction.normalized()
		last_direction = direction 
		update_animation(direction)
	else:
		update_idle_animation()  

	velocity = direction * speed
	move_and_slide()

func update_animation(direction):
	if currentHealth == 3:
		if direction.y > 0:
			anim_sprite.play("walkDown")
		elif direction.y < 0:
			anim_sprite.play("walkUp")
			anim_sprite.flip_h = false
		elif direction.x != 0:
			anim_sprite.play("walkX")
			anim_sprite.flip_h = direction.x > 0 
	
	elif currentHealth == 2:
		if direction.y > 0:
			anim_sprite.play("oneHandDown")
		elif direction.y < 0:
			anim_sprite.play("oneHandUp")
			anim_sprite.flip_h = false
		elif direction.x != 0:
			anim_sprite.play("oneHandX")
			anim_sprite.flip_h = direction.x > 0 
	
	elif currentHealth == 1:
		if direction.y > 0:
			anim_sprite.play("oneFeetDown")
		elif direction.y < 0:
			anim_sprite.play("oneFeetUp")
			anim_sprite.flip_h = false
		elif direction.x != 0:
			anim_sprite.play("oneFeetX")
			anim_sprite.flip_h = direction.x > 0 

func update_idle_animation():
	if currentHealth == 3:
		if last_direction.y > 0:
			anim_sprite.play("idleDown")
		elif last_direction.y < 0:
			anim_sprite.play("idleUp")
			anim_sprite.flip_h = false
		else:
			anim_sprite.play("idleX")
			anim_sprite.flip_h = last_direction.x > 0 

	elif currentHealth == 2:
		if last_direction.y > 0:
			anim_sprite.play("oneHandIdleDown")
		elif last_direction.y < 0:
			anim_sprite.play("oneHandIdleUp")
			anim_sprite.flip_h = false
		else:
			anim_sprite.play("oneHandIdleX")
			anim_sprite.flip_h = last_direction.x > 0 

	elif currentHealth == 1:
		if last_direction.y > 0:
			anim_sprite.play("oneFeetIdleDown")
		elif last_direction.y < 0:
			anim_sprite.play("oneFeetIdleUp")
			anim_sprite.flip_h = false
		else:
			anim_sprite.play("oneFeetIdleX")
			anim_sprite.flip_h = last_direction.x > 0 



func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.name == "hitBox":
		currentHealth -= 1
		
		call_deferred("set_global_position", $"../../tpCave/GoCave".global_position)
		
		$"../../CanvasLayer3/HBoxContainer".visible = true
		$"../../CanvasLayer3/ColorRect".visible = true
		$"../../CanvasLayer3/AudioStreamPlayer2D".play()
		set_physics_process(false) 
		
		await get_tree().create_timer(1.5).timeout
		
		set_physics_process(true)
		$"../../CanvasLayer3/HBoxContainer".visible = false
		$"../../CanvasLayer3/ColorRect".visible = false

		if currentHealth == 2:
			$"../../CanvasLayer/oneHP".visible = false
			$"../../CanvasLayer/twoHP".visible = true
			$"../../CanvasLayer/fullHP".visible = false

		elif currentHealth == 1:
			$"../../CanvasLayer/oneHP".visible = true
			$"../../CanvasLayer/twoHP".visible = false
			$"../../CanvasLayer/fullHP".visible = false

		elif currentHealth == 0:
			call_deferred("game_over")

		print_debug("pv =", currentHealth)

func game_over():
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
