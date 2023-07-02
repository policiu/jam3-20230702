extends CharacterBody2D


enum State {
	IDLE,
	ATTACK,
	HURT,
}


var state: State = State.IDLE:
	set(value):
		state = value
		state_timer = 0
var state_timer: int = 0


const SPEED = 150.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


const cooldown: int = 2
@export var AttackNode: Node = null


func _physics_process(delta: float):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("ui_cancel"):
		state = State.ATTACK

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
#	if abs(velocity.x):
#		scale.x = sign(velocity.x)
	
	for c in get_children():
		if c is Sprite2D:
			c.visible = false
	
	match state:
		State.IDLE:
			if is_on_floor():
				($Walk if abs(velocity.x) > 0 else $Idle).visible = true
				$Walk.frame = int(state_timer / 4.0) % 4
			else:
				$Jump.visible = true
				$Jump.frame = (velocity.y > -300)
		State.ATTACK:
			$Attack.visible = true
			var frame_dur: int = 4
			$Attack.frame = min(state_timer / float(frame_dur), 2)
			if state_timer >= frame_dur * 3:
				state = State.IDLE
		State.HURT:
			pass
	
	state_timer += 1
