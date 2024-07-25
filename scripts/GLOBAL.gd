extends Node

var rng = RandomNumberGenerator.new()
var score: int
var credits: int


var run_time
var distance: float
var enemmies_killed: int
var coins: int
var hearts: int
var gemes: int
var cards_used: int 

var deck: Array
var hand_size: int
var hand: Array
var card: String

func _ready():
	deck = ["jump", "dash", "shoot"]
	hand_size = 4
	credits = 3
	create_hand()

func create_hand():
	for i in hand_size:
		hand.insert(i,deck[int(rng.randf_range(0,deck.size()))])

func substitute_card(pos:int):
	hand[pos] = deck[int(rng.randf_range(0,deck.size()))]

func get_card(pos:int):
	card = hand[pos]
	hand[pos] = "none"
	return card
	
func get_hand():
	return hand
	
