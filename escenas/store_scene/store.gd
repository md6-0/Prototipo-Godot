extends Control

var items = []
@onready var item_list = $ScrollContainer/GridContainer
@onready var coins_label = $Coins_Label
@onready var gems_label = $Gems_Label
@onready var button = $Button

func _ready():
	items = preload("res://escenas/store_scene/store_item.gd").ITEMS
	coins_label.text = "Coins: " + str(GLOBAL.coins)
	gems_label.text = "Gems: " + str(GLOBAL.gemes)
	button.grab_focus()
	update_credits_label()
	populate_shop()

func _process(_delta):
	update_credits_label()

func update_credits_label():
	coins_label.text = "Coins: " + str(GLOBAL.coins)
	gems_label.text = "Gems: " + str(GLOBAL.gemes)

func populate_shop():
	for item_data in items:
		var item_container = preload("res://escenas/store_scene/item_button.tscn").instantiate()
		item_container.item_name = item_data.name
		item_container.item_icon = item_data.icon
		item_container.item_description = item_data.description
		item_container.item_credits = item_data.price
		
		if GLOBAL.deck:
			for item in GLOBAL.deck:
				if item_data.name == item:
					item_container.item_sold = true
		else: item_container.item_sold = false
		item_container.custom_minimum_size = Vector2(150,180)
		item_list.add_child(item_container)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://escenas/main_menu_scene/main_menu_scene.tscn")
