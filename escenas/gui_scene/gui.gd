extends Control

var a: Sprite2D
var b: Sprite2D
var x: Sprite2D
var y: Sprite2D
var hand: Array
var score_label: Label
var coins = Label
var hearts = []

func _ready():
	a = $CanvasLayer/MarginContainer/A
	b = $CanvasLayer/MarginContainer/B
	x = $CanvasLayer/MarginContainer/X
	y = $CanvasLayer/MarginContainer/Y
	hearts = [$CanvasLayer/MarginContainer/Heart, $CanvasLayer/MarginContainer/Heart2, $CanvasLayer/MarginContainer/Heart3]

func _process(_delta):
	update_cards_gui()
	update_credits()

func update_credits():
	for i in range(3):
		hearts[i].visible = i < GLOBAL.credits

func update_cards_gui():
	hand = GLOBAL.get_hand()
	update_sprite(a, hand[0])
	update_sprite(b, hand[1])
	update_sprite(x, hand[2])
	update_sprite(y, hand[3])

func update_sprite(sprite: Sprite2D, action: String):
	match action:
		"jump":
			sprite.texture = load("res://assets/Up.png")
			sprite.modulate = Color.CADET_BLUE
		"dash":
			sprite.texture = load("res://assets/Right.png")
			sprite.modulate = Color.KHAKI
		"shoot":
			sprite.texture = load("res://assets/shoot.png")
			sprite.modulate = Color.INDIAN_RED
		_:
			sprite.texture = load("res://assets/emptycard.png")
			sprite.modulate = Color.GRAY
			
