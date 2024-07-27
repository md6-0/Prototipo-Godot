extends Control

var is_paused:bool = false
@onready var canvas_layer = $CanvasLayer
@onready var continue_btn = $CanvasLayer/Continue
@onready var audio_stream_player = $AudioStreamPlayer

func _unhandled_input(event):
	if event.is_action_pressed("Start"):
		is_paused = not is_paused
		get_tree().paused = is_paused
		canvas_layer.visible = is_paused
		if is_paused:
			continue_btn.grab_focus()

func _on_continue_pressed():
	is_paused = not is_paused
	get_tree().paused = is_paused
	canvas_layer.visible = is_paused
	continue_btn.grab_focus()

func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://escenas/main_menu_scene/main_menu_scene.tscn")

func _on_exit_pressed():
	get_tree().quit()

func _on_continue_focus_entered():
	audio_stream_player.play()

func _on_menu_focus_entered():
	audio_stream_player.play()

func _on_exit_focus_entered():
	audio_stream_player.play()
