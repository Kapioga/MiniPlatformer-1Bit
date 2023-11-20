extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	gravity_set(delta)
	player_anim()
	

	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite_2d.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func gravity_set(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
func player_anim():
	if velocity.x > 1:
		animated_sprite_2d.play("walk")
		animated_sprite_2d.flip_h = false
	elif velocity.x < -1:
		animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("idle")
		#animated_sprite_2d.flip_h = false
