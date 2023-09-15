extends Node2D


@export var Sound_blow:AudioStream
@export var Sound_snif:AudioStream
@export var Sound_xiqi:AudioStream

@onready var AudioPlay:AudioStreamPlayer = $AudioStreamPlayer
@onready var animate:AnimatedSprite2D = $AnimatedSprite2D
@onready var CoinLuncher:CPUParticles2D = $CPUParticles2D
@onready var AttackArea:Area2D = $AttackArea
@onready var Commontimer:Timer = $Timer
@onready var BreathArea:Area2D = $BreathArea


var attackTime:float = 0.4
var BreathTime:float = 0.4




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_elta):
	global_position.x = get_global_mouse_position().x
	if Input.is_action_just_pressed("blow"):
		blow()
	if Input.is_action_just_pressed("snif"):
		snif()
	if Input.is_action_just_pressed("xiqi"):
		xiqi()
	HandleIdle()

func blow():
	if GlobalVars.NowCoins > 0:
		animate.stop()
		animate.play("chuiqi")
		CoinLuncher.restart()
		# CoinLuncher.emitting = true
		LoadAndPlay(Sound_blow)
		EnableAttack()
		GlobalVars.NowCoins-=1


func snif():
	animate.stop()
	animate.play("snif")
	LoadAndPlay(Sound_snif)
	pass


func xiqi():
	animate.stop()
	animate.play("xiqi")
	LoadAndPlay(Sound_xiqi)
	EnableBreath()
	
func LoadAndPlay(TheStream:AudioStream):
	AudioPlay.stop()
	AudioPlay.stream = TheStream
	AudioPlay.play()
	pass

func EnableAttack():
	AttackArea.monitoring = true
	Commontimer.wait_time = attackTime
	Commontimer.start()
	
func EnableBreath():
	BreathArea.monitoring = true
	Commontimer.wait_time = BreathTime
	Commontimer.start()

func HandleIdle():
	if not animate.is_playing() and animate.animation != "idle":
		animate.play("Idle")

func _on_timer_timeout():
	if AttackArea.monitoring:
		AttackArea.monitoring = false
		# 停止攻击
	if BreathArea.monitoring:
		BreathArea.monitoring = false
		# 停止吸气动作
	pass # Replace with function body.


func _on_attack_area_body_entered(body):
	# 攻击区域检测到body
	if body.is_in_group("enemy"):
		body.Blowed()
		GlobalVars.Score += randi_range(100,200)
	pass # Replace with function body.


func _on_breath_area_body_entered(body):
	# 呼吸区检测到body
	if body.is_in_group("coins"):
		#吸金
		if GlobalVars.NowCoins < GlobalVars.MaxCoins:
			GlobalVars.NowCoins += 1
	if body.is_in_group("enemy"):
		# 吹起
		body.Blowed()
		
	pass # Replace with function body.
