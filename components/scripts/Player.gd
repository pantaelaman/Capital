extends KinematicBody2D

const GRAVITY = 8.0
const SPEED = 4.0
const JUMP_SPEED = 25.0

var velocity = Vector2()

var moving = false
var arial = false

var jump_velocity = 0
var speed_modifier = 1

func _ready():
	pass
	

func _physics_process(delta):
	velocity.y = GRAVITY * 1000
	velocity.x = 0
	
	if is_on_floor():
		if Input.is_action_pressed("act_lshift"):
			speed_modifier = 2
		else:
			speed_modifier = 1
	
	moving = false
	if Input.is_action_pressed("act_right"):
		velocity.x += SPEED * 1000 * speed_modifier
		moving = true
		$view.flip_h = false
	if Input.is_action_pressed("act_left"):
		velocity.x -= SPEED * 1000 * speed_modifier
		moving = true
		$view.flip_h = true
	
	if Input.is_action_just_pressed("act_up") && is_on_floor():
		jump_velocity -= JUMP_SPEED * 1000
	
	jump_velocity = lerp(jump_velocity, 0, 0.04)
	
	arial = !is_on_floor()
	
	velocity.y += jump_velocity
	print(velocity.y)
	
	handle_view()
	move_and_slide(velocity * delta, Vector2.UP)
	

func handle_view():
	if arial:
		$view.animation = 'arial'
		return
	if moving:
		$view.animation = 'walking'
		return
	$view.animation = 'default'
	
