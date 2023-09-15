extends Control

@export var InitInfo:Dictionary
var TextName:String = ""
var score:String= "6550"
var date:String = "none"
# Called when the node enters the scene tree for the first time.
func _ready():
	if InitInfo:
		Load_From_Info(InitInfo)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func Load_From_Info(Info:Dictionary):
	# read score,name and date Info from 
	$HBoxContainer/Label_name.text = Info["name"]
	$HBoxContainer/Label_score.text = Info["score"]
	$HBoxContainer/Label_date.text = Info["date"]
