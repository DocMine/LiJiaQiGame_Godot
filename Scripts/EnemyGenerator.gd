extends Node2D

@onready var GeneratorTimer:Timer = $Timer
@export var EnemyScene:PackedScene = load("res://Scenes/Lijiaqi.tscn")
var enemycont:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	GeneratorTimer.wait_time = GlobalVars.EnemyBornTime
	GeneratorTimer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var c:Node2D = EnemyScene.instantiate()
	get_parent().add_child(c)
	c.global_position.y = global_position.y
	c.global_position.x = randi_range(100,1800)
	c.CampFire = $"../Camp"
	enemycont+=1
	if enemycont >= GlobalVars.MaxFlyEnemy:
		GeneratorTimer.stop()
