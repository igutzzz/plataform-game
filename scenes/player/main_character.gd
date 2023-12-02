extends CharacterBody2D
class_name Player

const SPEED = 400.0
const JUMP_VELOCITY = -900.0

var jumps = 0
var isDoubleJump = false

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


#func _process(delta):
#	while isDoubleJump and not is_on_floor():
#		print("jumpando")

		
func _ready():
	GameManager.player = self

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if Input.is_action_just_pressed("jump") and jumps < 1:
			isDoubleJump = true
			velocity.y = JUMP_VELOCITY * 0.75
			jumps = jumps +1
		else:
#			sprite_2d.animation = "jump"
			velocity.y += gravity * delta	
				
	if(position.y >=1100):
		die()
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jumps = 0
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 100)

	move_and_slide()
	
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft	
	animationHandler(velocity.x)

func animationHandler(velocityX):
	if is_on_floor():
		if(velocityX > 1 || velocityX < -1):
			animation_player.play("run")
		else:
			animation_player.play("idle")
	else:
		if isDoubleJump:
			animation_player.play("double_jump", )
		else:
			animation_player.play("jump")


func _animation_player_animation_finished(anim_name):
	if anim_name ==  "double_jump":
		isDoubleJump = false

func _input(event: InputEvent):
	if event.is_action_pressed("down") and is_on_floor():
			position.y +=1
			
func die():
	GameManager.respawn()
	

