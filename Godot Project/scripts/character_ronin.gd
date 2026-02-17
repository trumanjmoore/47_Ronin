extends CharacterBody2D

@export var speed = 60
@export var jump_speed = -200
@export var gravity = 500
var combo_count: int = 0
@onready var combo_timer: Timer = $ComboTimer

var attack_index = 0
var sheathing = false
var timedout = false
var attacking = false
var jumping = false

func _process(delta: float) -> void:
	if !sheathing and !jumping:
		if Input.is_action_just_pressed("attack"):
			if Input.is_action_pressed("ui_up"):
				$AnimatedSprite2D.play("attack_up")
				attack_index = 4
				attacking = true
			match attack_index:
				0:
					$AnimatedSprite2D.play("attack_one")
					attack_index = 1
					attacking = true
				1:
					if !attacking:
						$AnimatedSprite2D.play("attack_two")
						attack_index = 2
						attacking = true
						$ComboTimer.stop()
				2:
					if !attacking:
						$AnimatedSprite2D.play("attack_three")
						attack_index = 3
						attacking = true
						$ComboTimer.stop()
		elif !attacking and attack_index == 0:
			if Input.is_action_just_pressed("space"):
				$AnimatedSprite2D.play("jump")
				jumping = true
			elif !jumping:
				if velocity.x < 0:
					$AnimatedSprite2D.flip_h = true
					$AnimatedSprite2D.play("walking")
				elif velocity.x > 0:
					$AnimatedSprite2D.flip_h = false
					$AnimatedSprite2D.play("walking")
				else:
					$AnimatedSprite2D.play("breathing")
	
	

func _physics_process(delta):

	if !attacking and attack_index == 0:
		# Add gravity every frame
		velocity.y += gravity * delta
		velocity.x = Input.get_axis("ui_left", "ui_right") * speed
		move_and_slide()

	# Only allow jumping when on the ground
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = jump_speed

func _sheath() -> void:
	$AnimatedSprite2D.play("sheath")
	sheathing = true
	attack_index = 0
	timedout = false;
	attacking = false

func _on_animated_sprite_2d_animation_finished() -> void:
	if sheathing:
		sheathing = false
	elif jumping:
		jumping = false
	elif attack_index > 2:
		_sheath()
	elif attack_index > 0:
		$ComboTimer.start(.2)
		attacking = false


func _on_combo_timer_timeout() -> void:
	_sheath()
	$ComboTimer.stop()
