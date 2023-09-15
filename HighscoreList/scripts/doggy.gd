extends CharacterBody2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	velocity = Vector2(randi_range(-300,300), randi_range(-300,300))

func _physics_process(_delta):
	move_and_slide()
	if get_slide_collision_count() > 0:
		var targetpos = get_slide_collision(0).get_position()
		velocity = (global_position - targetpos).normalized() * randi_range(200,300)


