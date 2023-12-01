extends CharacterBody2D


const SPEED = 100
const JUMP_VELOCITY = -400.0
const PLAYER = "Player"

var direction = -1


@onready var sprite_2d = $Sprite2D
@onready var ray_cast_2d =$RayCast2D
@onready var top = $Top
@onready var sides = $Sides



func _process(delta):
	var topAreas = top.get_overlapping_areas()
	var sideAreas = sides.get_overlapping_areas()
	for area in topAreas:
		var parent = area.get_parent()
		if(parent.name == PLAYER):
			sprite_2d.play("hit")
			if(sprite_2d.animation_finished):
				queue_free()
	for area in sideAreas:
		var parent = area.get_parent()	
		if(parent.name == PLAYER):
			print('morreu')
			

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _physics_process(delta):
	
	
	
	# Add the gravity.
	if(velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "run"
	else:
		sprite_2d.animation = "default"
	if not is_on_floor():
		velocity.y += gravity * delta	
	# Get the input direction and handle the movement/deceleration.

	var isLeft = direction > 0
	
	if(!ray_cast_2d.is_colliding()):
		direction = direction * -1
		velocity.x = direction * SPEED
		sprite_2d.flip_h = isLeft
		ray_cast_2d.position.x = ray_cast_2d.position.x *-1
	else:
		if direction:
			velocity.x = direction * SPEED
			sprite_2d.flip_h = isLeft
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
#	if(velocity.x == 0):
#		direction = direction * -1
#		print(direction)

	move_and_slide()
	
	if(velocity.x == 0):
		direction = direction *-1
		ray_cast_2d.position.x = ray_cast_2d.position.x *-1

