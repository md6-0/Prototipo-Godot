extends Control

@onready var start = $CanvasLayer/Start
@onready var audio_stream_player = $AudioStreamPlayer

func _ready():
	start.grab_focus()

func _on_exit_pressed():
	get_tree().quit()


func _on_start_pressed():
	get_tree().change_scene_to_file("res://escenas/game_scene/game.tscn")


func _on_exit_focus_exited():
	audio_stream_player.play()


func _on_start_focus_exited():
	audio_stream_player.play()
