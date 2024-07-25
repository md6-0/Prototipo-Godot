extends RigidBody2D

@onready var sprite_2d = $Sprite2D
@onready var audio_stream_player = $AudioStreamPlayer
@onready var area_2d_collision_shape_2d = $Area2D/Area2D_CollisionShape2D

func _on_area_2d_body_entered(body):
	if body is Player:
		GLOBAL.score += 200
		GLOBAL.coins += 1
		sprite_2d.visible = false
		area_2d_collision_shape_2d.disabled = true
		if not audio_stream_player.playing:
			audio_stream_player.play()

func _on_audio_stream_player_finished():
	GLOBAL.gemes += 1
	queue_free()
