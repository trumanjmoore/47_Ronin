extends CharacterBody2D

@export var speed = 100
@export var jump_speed = -100
@export var gravity = 500


func _process(delta: float) -> void:
	if velocity.x != 0 || velocity.y != 0:
		$AnimatedSprite2D.stop()
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("breathing")
	

func _physics_process(delta):
	# Add gravity every frame
	velocity.y += gravity * delta

	# Input affects x axis only
	velocity.x = Input.get_axis("ui_left", "ui_right") * speed

	move_and_slide()

	# Only allow jumping when on the ground
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = jump_speed
