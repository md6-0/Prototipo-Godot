extends Area2D

const SPEED = 700

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position.x += SPEED * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
