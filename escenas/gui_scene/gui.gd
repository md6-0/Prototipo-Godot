extends Control

var a: Sprite2D
var b: Sprite2D
var x: Sprite2D
var y: Sprite2D
var hand: Array
var score_label: Label
var coins = Label
var heart :Sprite2D
var heart2 :Sprite2D
var heart3 :Sprite2D

func _ready():
	a = $CanvasLayer/MarginContainer/A
	b = $CanvasLayer/MarginContainer/B
	x = $CanvasLayer/MarginContainer/X
	y = $CanvasLayer/MarginContainer/Y
	heart = $CanvasLayer/MarginContainer/Heart
	heart2 = $CanvasLayer/MarginContainer/Heart2
	heart3 = $CanvasLayer/MarginContainer/Heart3

func _process(_delta):
	update_cards_gui()
	update_credits()

func update_credits():
	if GLOBAL.credits == 0:
		heart.visible = false
		heart2.visible = false
		heart3.visible = false
	elif GLOBAL.credits == 1:
		heart.visible = true
		heart2.visible = false
		heart3.visible = false
	elif GLOBAL.credits == 2:
		heart.visible = true
		heart2.visible = true
		heart3.visible = false
	elif GLOBAL.credits == 3:
		heart.visible = true
		heart2.visible = true
		heart3.visible = true

func update_cards_gui():
	hand = GLOBAL.get_hand()
	if hand[0] == "jump":
		a.texture = load("res://assets/Up.png")
	elif hand[0] == "dash":
		a.texture = load("res://assets/Right.png")
	elif hand[0] == "shoot":
		a.texture = load("res://assets/shoot.png")
	else:
		a.texture = load("res://assets/Player.png")
		
	if hand[1] == "jump":
		b.texture = load("res://assets/Up.png")
	elif hand[1] == "dash":
		b.texture = load("res://assets/Right.png")
	elif hand[1] == "shoot":
		b.texture = load("res://assets/shoot.png")
	else:
		b.texture = load("res://assets/Player.png")

	if hand[2] == "jump":
		x.texture = load("res://assets/Up.png")
	elif hand[2] == "dash":
		x.texture = load("res://assets/Right.png")
	elif hand[2] == "shoot":
		x.texture = load("res://assets/shoot.png")
	else:
		x.texture = load("res://assets/Player.png")
		
	if hand[3] == "jump":
		y.texture = load("res://assets/Up.png")
	elif hand[3] == "dash":
		y.texture = load("res://assets/Right.png")
	elif hand[3] == "shoot":
		y.texture = load("res://assets/shoot.png")
	else:
		y.texture = load("res://assets/Player.png")


