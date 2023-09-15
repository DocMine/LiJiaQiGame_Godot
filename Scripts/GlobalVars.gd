extends Node

@export var Score:int=0
@export var MaxCoins:int=10
@export var NowCoins:int=5

@export var MaxFlyEnemy:int = 6
@export var EnemyBornTime:float = 15
# generate enemy every 7 seconds

@export var AwakeningSisters:int = 0
@export var TotalSisters:int = 10
# Called when the node enters the scene tree for the first time.

var ScoreInfo = {"name":"未知玩家", "score": "556", "date": "2023.5.6"}
var date:String = ""

func _ready():
	var c = Time.get_datetime_dict_from_system()
	date = str(c["year"])+"-"+str(c["month"])+"-"+str(c["day"])
	pass # Replace with function body.

func _process(delta):
	ScoreInfo["score"] = str(Score)
	ScoreInfo["date"] = date
