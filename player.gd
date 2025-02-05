extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	# VARIABLES
	var velocity = Vector2()
	var moveSpeed = 200

	# ANIMATION CONTROL
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0

	# INPUT
	if Input.is_action_pressed("move_right"):
		velocity.x += moveSpeed
	if Input.is_action_pressed("move_left"):
		velocity.x -= moveSpeed
	if Input.is_action_pressed("move_down"):
		velocity.y += moveSpeed
	if Input.is_action_pressed("move_up"):
		velocity.y -= moveSpeed

	# MOVEMENT
	position += velocity * delta
	position = position.clamp(Vector2(), screen_size)