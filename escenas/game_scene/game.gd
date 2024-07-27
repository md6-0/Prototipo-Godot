extends Node2D

var game_over_timer: Timer
var game_over_gui: PackedScene
var gui: Node
var game_over_showing: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	game_over_gui = preload("res://escenas/game_over_scene/game_over_scene.tscn")
	game_over_timer = $Timers/Game_over_timer
	gui = $GUI
	game_over_showing = false
	

func _on_game_over_timer_timeout():
	game_over_timer.stop()
	game_over_showing = true
	add_child(game_over_gui.instantiate())
	gui.queue_free()
	

