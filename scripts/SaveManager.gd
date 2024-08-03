extends Node

# Diccionario para almacenar datos del juego
var save_data = {}

# Ruta del archivo de guardado
var save_path = "user://save_game.json"

# Guardar el juego en un archivo JSON
func save_game():
	# Accedemos al archivo de guardado en modo escritura
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		# Guardamos los créditos
		save_data["credits"] = GLOBAL.credits
		save_data["gems"] = GLOBAL.gemes
		save_data["deck"] = GLOBAL.deck
		
		# Pasamos el diccionario a un JSON
		var json_data = JSON.stringify(save_data)
		
		# Guardamos el JSON en formato String en el archivo de guardado y cerramos el archivo de guardado
		file.store_string(json_data)
		file.close()
		print(save_data)
		print("Game saved successfully!")
		
	else:
		print("Failed to open save file for writing.")

# Cargar el juego desde un archivo JSON
func load_game():
	# Comprobamos si el archivo existe antes de intentar abrirlo
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		if file:
			# Obtenemos el json del archivo y lo convertimos a un diccionario
			var json_data = file.get_as_text()
			var parse_result = JSON.parse_string(json_data)
			if parse_result != null:
				save_data = parse_result
				# Obtenemos los datos y los guardamos en GLOBAL
				GLOBAL.credits = save_data.get("credits")
				GLOBAL.gems = save_data.get("gems")
				GLOBAL.deck = save_data.get("deck")
				print("Game loaded successfully!")
			else:
				print("Failed to parse save file.")
			file.close()
		else:
			print("Failed to open save file for reading.")
	else:
		print("No save file found.")

# Borrar el archivo de guardado
func delete_save():
	GLOBAL.reset_vars()
	save_data = {}
	save_game()
	load_game()
	print("Save file deleted!")

