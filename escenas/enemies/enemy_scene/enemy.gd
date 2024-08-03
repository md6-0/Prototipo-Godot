extends Node2D

@onready var audio_stream_player = $AudioStreamPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var area_2d = $Area2D

@onready var amplitude = 50.0
@onready var speed = 2.0 
@onready var initial_position = global_position
@onready var gem_scene: PackedScene = preload("res://escenas/gem_scene/geme_Scene.tscn")

var time_passed = 0.0
var phase_offset = randf_range(0.0, TAU)
var killed_by_shoot: bool


func _physics_process(delta):
	# Acumular tiempo
	time_passed += delta
	# Movimiento senoidal con desfase aleatorio
	global_position.y = initial_position.y + amplitude * sin(speed * time_passed + phase_offset)


#Función que detecta cuerpos colisionando con el enemigo
#Ahora se usa sólo para detectar al personaje
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
		killed_by_shoot = true
		area_2d.queue_free()
		animated_sprite_2d.visible = false
		area.queue_free()
		GLOBAL.score += 50
		audio_stream_player.play()

#Cuando el audio acaba, eliminamos al personaje.
func _on_audio_stream_player_finished():
	GLOBAL.enemmies_killed += 1
	if killed_by_shoot:
		spawn_gemes()
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func spawn_gemes():
	var num_coins = randi() % 5 + 1  
	for i in range(num_coins):
		var gem_instance = gem_scene.instantiate()
		var offset = Vector2(randf_range(-10, 10), randf_range(-10, 10))
		gem_instance.position = self.position + offset
		get_parent().add_child(gem_instance)
		# Aplicar una fuerza hacia arriba para que las monedas boten
		var impulse = Vector2(randf_range(150, 200), randf_range(-400, -200))
		gem_instance.apply_impulse(impulse, impulse)
