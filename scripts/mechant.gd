extends CharacterBody2D

const speed = 45

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var raycast := $RayCast2D 
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

var last_direction := Vector2.LEFT

func _physics_process(_delta: float) -> void:
	raycast.target_position = to_local(player.global_position)
	raycast.force_raycast_update()
	
	if raycast.is_colliding() and raycast.get_collider() != player:
		velocity = Vector2.ZERO
		update_idle_animation()
	else:
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		dir = (dir + Vector2(randf_range(-0.3, 0.3), randf_range(-0.3, 0.3))).normalized()
		velocity = dir * speed
		
		if dir != Vector2.ZERO:
			last_direction = dir
			update_animation(dir)
	
	move_and_slide()

func makepath() -> void:
	nav_agent.target_position = player.global_position
	
func _on_timer_timeout():
	makepath()

var previous_direction := Vector2.ZERO
const direction_threshold := 0.3 

func update_animation(direction):
	if previous_direction.distance_to(direction) < direction_threshold:
		return

	previous_direction = direction 
	
	if abs(direction.x) > abs(direction.y): 
		anim_sprite.play("walkX")
		anim_sprite.flip_h = direction.x > 0 
	elif direction.y < 0:
		anim_sprite.play("walkUp")
		anim_sprite.flip_h = false
	elif direction.y > 0:
		anim_sprite.play("walkDown")
		anim_sprite.flip_h = false

func update_idle_animation():
	if last_direction.y > 0:
		anim_sprite.play("idleDown")
	elif last_direction.y < 0:
		anim_sprite.play("idleUp")
	else:
		anim_sprite.play("idleX")
		anim_sprite.flip_h = last_direction.x > 0
