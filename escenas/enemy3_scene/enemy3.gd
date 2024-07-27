extends Node2D

@onready var sprite_2d = $Sprite2D
@onready var player_detected = false
@onready var shoot_timer = $Shoot_Timer
@onready var ProjectileScene = preload("res://escenas/enemy3_scene/enemy3_shoot.tscn")
@onready var shoot_position = $Marker2D
var already_shoot = false

var player

func _on_area_2d_body_entered(body):
	if body is Player and not body.is_dead:
		player = body
		player_detected = true
		shoot()

func shoot():
	var projectile = ProjectileScene.instantiate()
	projectile.global_position = shoot_position.global_position
	var direction = (player.global_position + Vector2(randf_range(100, 225),0) - shoot_position.global_position).normalized()
	projectile.direction = direction
	get_tree().call_group("levels", "add_child", projectile)

