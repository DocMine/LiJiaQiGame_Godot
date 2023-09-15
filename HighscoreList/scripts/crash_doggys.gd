extends Control

var dog
# Called when the node enters the scene tree for the first time.
func _ready():
	dog = preload("res://HighscoreList/Scenes/doggy.tscn")
	for x in range(6):
		var c = dog.instantiate()
		add_child(c)
		c.global_position = Vector2(randi_range(0,1920),randi_range(0,1080))
