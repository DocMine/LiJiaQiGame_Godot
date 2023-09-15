extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -800.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var VRange = [-600,200]

@onready var head:Sprite2D = $AnimatedSprite2D/LJQ_Head
@onready var BodySprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var AudioPlay:AudioStreamPlayer = $AudioStreamPlayer
@onready var VTimer:Timer = $VelocityTimer

@export var Sound_LuanShuo:AudioStream = load("res://Assets/Audios/fanche/luanshuo.wav")
@export var Sound_Naliguile:AudioStream = load("res://Assets/Audios/fanche/naliguile.wav")
@export var Sound_RenzhenGongzuo:AudioStream = load("res://Assets/Audios/fanche/zhangmeizhang.wav")
@export var Sound_Fengdiaole:AudioStream = load("res://Assets/Audios/fanche/fengdiaole.wav")

@export var CampFire:CollisionObject2D

@onready var FaldAudioList = [Sound_LuanShuo, Sound_Naliguile, Sound_RenzhenGongzuo, Sound_Fengdiaole]
# 失败音效，随机播放

func _ready():
	gravity = 500
		


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		pass
		
	if velocity.x >0:
		BodySprite.scale.x = abs(BodySprite.scale.x)
	if velocity.x < 0:
		BodySprite.scale.x = -abs(BodySprite.scale.x)
	velocity.x = move_toward(velocity.x, 0, 1)
	AttackTarget(CampFire)
	move_and_slide()


func _on_velocity_timer_timeout():
	velocity.x = randi_range(VRange[0],VRange[1])
	pass # Replace with function body.

func Blowed():
	# 随机播放音效
	AudioPlay.stream = FaldAudioList[randi_range(0,len(FaldAudioList)-1)]
	AudioPlay.play()
	velocity.y = JUMP_VELOCITY
	#queue_free()
	pass

func AttackTarget(traget):
	if is_on_floor():
		# 落地跑向篝火
		velocity.x = (traget.global_position - global_position).normalized().x * SPEED
