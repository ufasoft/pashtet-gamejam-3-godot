extends CharacterBody2D


@onready var animated_sprite = $AnimatedSprite


const SPEED = 400.0
const JUMP_VELOCITY = -1000.0
const GRAVITY = 1500


func _physics_process(delta):
	move(delta)
	move_and_slide()

func move(delta):
	control()
	jump()
	jump_off()
	fall(delta)

func control():
	var direction = int(Input.get_axis("move_left", "move_right"))

	velocity.x = direction * SPEED

	match direction:
		1:
			animated_sprite.flip_h = false
			animated_sprite.play("move")
		-1:
			animated_sprite.flip_h = true
			animated_sprite.play("move")
		0:
			animated_sprite.play("idle")

func jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func jump_off():
	if Input.is_action_pressed("move_down"):
		self.set_collision_mask_value(2, false)
		await get_tree().create_timer(0.05).timeout
		self.set_collision_mask_value(2, true)

func fall(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta

		animated_sprite.play("jump")
