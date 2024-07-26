extends Node


const SEGMENT_LENGTH = 1800 # Longitud de cada segmento
var generated_segments = [] # Array para manejar los segmentos generados
var segment_scenes = [] # Array para almacenar las escenas de los segmentos
var is_second_segment = true

# Cargar las escenas de los segmentos
var segment_scene_0 = preload("res://escenas/segments_scenes/segment_scene_0.tscn")
var segment_scene_1 = preload("res://escenas/segments_scenes/segment_scene_1.tscn")
var segment_scene_2 = preload("res://escenas/segments_scenes/segment_scene_2.tscn")
var segment_scene_3 = preload("res://escenas/segments_scenes/segment_scene_3.tscn")
var segment_scene_4 = preload("res://escenas/segments_scenes/segment_scene_4.tscn")
var segment_scene_5 = preload("res://escenas/segments_scenes/segment_scene_5.tscn")

var player: Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../Player")
	
	# Añadir las escenas de los segmentos al array
	segment_scenes.append(segment_scene_1)
	segment_scenes.append(segment_scene_1)
	segment_scenes.append(segment_scene_2)
	segment_scenes.append(segment_scene_2)
	segment_scenes.append(segment_scene_3)
	segment_scenes.append(segment_scene_3)
	segment_scenes.append(segment_scene_4)
	segment_scenes.append(segment_scene_4)
	segment_scenes.append(segment_scene_5)
	# Generar los 6 primeros segmentos del nivel
	spawn_first_segment()
	for i in range(5):
		spawn_segment()

func spawn_first_segment():
	# Seleccionar una escena de segmento al azar
	var new_segment = segment_scene_0.instantiate()
	
	# Añadir el nuevo segmento a la escena y a la cola
	add_child(new_segment)
	generated_segments.append(new_segment)

func spawn_segment():
	# Obtenemos un nuevo segmento aleatorio
	var new_segment = segment_scenes[randi() % segment_scenes.size()].instantiate()
	
	# Calcular la posición del nuevo segmento
	var last_segment_position_x = 0
	last_segment_position_x = generated_segments[-1].position.x # Obtenemos la pos x del último segmento generado
	if is_second_segment:
		new_segment.position.x = last_segment_position_x + 800
		is_second_segment = false
	else: 
		new_segment.position.x = last_segment_position_x + SEGMENT_LENGTH
	
	# Añadir el nuevo segmento a la escena y a la cola
	add_child(new_segment)
	generated_segments.append(new_segment)

func _process(delta):
	var player_position = player.position.x
	
	# Generar nuevos segmentos
	if generated_segments.size() > 0 and player_position > generated_segments[-1].position.x - SEGMENT_LENGTH:
		spawn_segment()
		
	# Eliminar segmentos antiguos
	if generated_segments.size() > 0 and player_position > generated_segments[0].position.x + SEGMENT_LENGTH + 400 :
		despawn_old_segment()

func despawn_old_segment():
	var old_segment = generated_segments.pop_front()
	old_segment.queue_free()
