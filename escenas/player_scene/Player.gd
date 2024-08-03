extends CharacterBody2D
class_name Player

const SPEED = 175.0
const JUMP_VELOCITY = -375.0
const SHAKE_AMOUNT = 5
const SHAKE_DURATION = 0.2
const DASH_SPEED = 675.0
const DASH_TIME = 0.35

@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var a_timer = $"../Timers/a_timer"
@onready var b_timer = $"../Timers/b_timer"
@onready var x_timer = $"../Timers/x_timer"
@onready var y_timer = $"../Timers/y_timer"
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var proyectile: PackedScene = preload("res://escenas/shoot_scene/shoot.tscn")
@onready var audio_stream_player = $AudioStreamPlayer
@onready var audio_stream_player_jump = $AudioStreamPlayer_jump
@onready var audio_stream_player_dash = $AudioStreamPlayer_dash
@onready var audio_stream_player_shoot = $AudioStreamPlayer_shoot
@onready var rng = RandomNumberGenerator.new()
@onready var camera = $Camera2D
@onready var level_music = $"../AudioStreamPlayer"
@onready var game_over_timer = $"../Timers/Game_over_timer"
@onready var dash_particles = $DashParticles

var is_dead = false
var shake_amount = 0.0
var shake_duration = 0.0
var is_dashing = false
var dash_timer = 0.0
var run_time = 0.0

func _physics_process(delta):
	if not is_dashing:
		animated_sprite_2d.modulate = Color.WHITE
	if is_dead:
		death_ctrl(delta)
	else:
		run_time += delta
		velocity.y += gravity * delta
		movement_ctrl(delta)
		animation_ctrl()
	apply_camera_shake(delta)
	move_and_slide()

func _input(_event):
	if not is_dead:
		if Input.is_action_just_pressed("A") and a_timer.is_stopped():
			perform_action(GLOBAL.get_card(0))
			a_timer.start()
		elif Input.is_action_just_pressed("B") and b_timer.is_stopped():
			perform_action(GLOBAL.get_card(1))
			b_timer.start()
		elif Input.is_action_just_pressed("X") and x_timer.is_stopped():
			perform_action(GLOBAL.get_card(2))
			x_timer.start()
		elif Input.is_action_just_pressed("Y") and y_timer.is_stopped():
			perform_action(GLOBAL.get_card(3))
			y_timer.start()

func movement_ctrl(delta):
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
			dash_particles.emitting = false
		if not is_on_floor() and velocity.y >= 0:
			velocity.y = 0
	else:
		velocity.x = SPEED

func animation_ctrl():
	if not is_on_floor():
		if animated_sprite_2d.animation != "jump":
			animated_sprite_2d.play("jump")
	else:
		if animated_sprite_2d.animation != "run":
			animated_sprite_2d.play("run")

func death_ctrl(delta):
	if velocity.x > 0:
		velocity.x -= 1.2
	else:
		velocity.x = 0
		GLOBAL.distance = calculate_distance()
		
	velocity.y += gravity * delta
	if animated_sprite_2d.animation != "die":
		animated_sprite_2d.play("die")
		GLOBAL.run_time = run_time
		game_over_timer.start()

func perform_action(card: String):
	match card:
		"Jump": jump_ctrl()
		"Dash": dash_ctrl()
		"Shoot": shoot_ctrl()
	GLOBAL.cards_used += 1

func jump_ctrl():
	audio_stream_player_jump.pitch_scale = rng.randf_range(0.8, 1.2)
	audio_stream_player_jump.play()
	velocity.y = JUMP_VELOCITY

func dash_ctrl():
	dash_particles.emitting = true
	animated_sprite_2d.modulate = Color.KHAKI
	audio_stream_player_dash.pitch_scale = rng.randf_range(0.8, 1.2)
	audio_stream_player_dash.play()
	is_dashing = true
	dash_timer = DASH_TIME
	velocity.x = DASH_SPEED

func shoot_ctrl():
	audio_stream_player_shoot.pitch_scale = rng.randf_range(0.8, 1.2)
	audio_stream_player_shoot.play()
	var proyectile_instance = proyectile.instantiate()
	proyectile_instance.global_position = global_position + Vector2(25, 0)
	get_tree().call_group("levels", "add_child", proyectile_instance)

func damage_ctrl(damage):
	if GLOBAL.credits > 0:
		if not is_dashing:
			audio_stream_player.play()
			shake_duration = SHAKE_DURATION
			GLOBAL.credits -= damage
			if GLOBAL.credits <= 0:
				is_dead = true
				velocity.x = SPEED
				collision_shape_2d.disabled = true

func apply_camera_shake(delta):
	if shake_duration > 0:
		shake_duration -= delta
		camera.offset = Vector2(rng.randf_range(-SHAKE_AMOUNT, SHAKE_AMOUNT), rng.randf_range(-SHAKE_AMOUNT, SHAKE_AMOUNT))
	else:
		camera.offset = Vector2.ZERO

func calculate_distance():
	return int(global_position.distance_to(Vector2.ZERO))

func _on_area_2d_area_entered(area):
	if area is Enemy3_shoot:
		damage_ctrl(1)
		area.queue_free()

func _on_a_timer_timeout():
	a_timer.stop()
	GLOBAL.substitute_card(0)

func _on_b_timer_timeout():
	b_timer.stop()
	GLOBAL.substitute_card(1)

func _on_x_timer_timeout():
	x_timer.stop()
	GLOBAL.substitute_card(2)

func _on_y_timer_timeout():
	y_timer.stop()
	GLOBAL.substitute_card(3)

