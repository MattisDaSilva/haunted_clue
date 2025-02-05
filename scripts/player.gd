extends CharacterBody2D

@export var speed: float = 55
@export var maxHealth: int = 3
@onready var currentHealth: int = 3
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
	if direction.y > 0:
		anim_sprite.play("walkDown")
		anim_sprite.flip_h = false 
	elif direction.y < 0:
		anim_sprite.play("walkUp")
		anim_sprite.flip_h = false
	elif direction.x != 0:
		anim_sprite.play("walkX")
		anim_sprite.flip_h = direction.x > 0 

func update_idle_animation():
	if last_direction.y > 0:
		anim_sprite.play("idleDown")
	elif last_direction.y < 0:
		anim_sprite.play("idleUp")
	else:
		anim_sprite.play("idleX")
		anim_sprite.flip_h = last_direction.x > 0 
