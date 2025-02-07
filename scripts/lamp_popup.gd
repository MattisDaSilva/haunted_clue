extends Control

@export var start_position: Vector2 = Vector2(640, -100)
@export var end_position: Vector2 = Vector2(640, 25)
@export var duration: float = 0.5

func show_popup():
	global_position = start_position 
	visible = true
	
	var tween = create_tween()
	tween.tween_property(self, "global_position", end_position, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	await get_tree().create_timer(2).timeout 

	var tween_out = create_tween()
	tween_out.tween_property(self, "global_position", start_position, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	
	await tween_out.finished
	visible = false 
