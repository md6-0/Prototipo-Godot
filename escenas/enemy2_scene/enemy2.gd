extends Node2D

@onready var audio_stream_player = $AudioStreamPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var area_2d = $Area2D
@onready var speed = 20.0 # Velocidad del movimiento

func _physics_process(delta):
	global_position.x += -speed * delta

#Función que detecta cuerpos colisionando con el enemigo
#Ahora se usa sólo para las balas el personaje
func _on_area_2d_body_entered(body):
	if body is Player and not body.is_dead:
		area_2d.queue_free()
		animated_sprite_2d.visible = false
		body.damage_ctrl(1)
		GLOBAL.score += 75
		audio_stream_player.play()

#Función que detecta areas colisionando con el enemigo
#Ahora se usa sólo para las balas del personaje
func _on_area_2d_area_entered(area):
	if area.is_in_group("shoot"):
		area_2d.queue_free()
		animated_sprite_2d.visible = false
		area.queue_free()
		GLOBAL.score += 50
		audio_stream_player.play()

#Cuando el audio acaba, eliminamos al personaje.
func _on_audio_stream_player_finished():
	GLOBAL.enemmies_killed += 1
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
		queue_free()
