extends Area2D

@onready var audio_stream_player = $AudioStreamPlayer
@onready var sprite_2d = $Sprite2D

func _on_body_entered(body):
	if body is Player:
		if GLOBAL.credits > 0 and GLOBAL.credits < 3:
			GLOBAL.credits += 1
		else: GLOBAL.score += 100
		sprite_2d.visible = false
		audio_stream_player.play()

func _on_audio_stream_player_finished():
	GLOBAL.hearts += 1
	queue_free()
