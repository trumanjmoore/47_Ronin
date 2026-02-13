extends CharacterBody2D

@export var speed = 60
@export var jump_speed = -100
@export var gravity = 500
var combo_count: int = 0
@onready var combo_timer: Timer = $ComboTimer

var attack_index = 0
var sheathing = false
var timedout = false
var attacking = false

func _process(delta: float) -> void:
	if !sheathing:
		if Input.is_action_just_pressed("attack"):
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
		elif attack_index == 0:
			if velocity.x < 0:
				$AnimatedSprite2D.flip_h = true
				$AnimatedSprite2D.play("walking")
			elif velocity.x > 0:
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("walking")
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

func _sheath() -> void:
	$AnimatedSprite2D.play("sheath")
	sheathing = true
	attack_index = 0
	timedout = false;
	attacking = false

func _on_animated_sprite_2d_animation_finished() -> void:
	if sheathing == true:
		sheathing = false
	elif attack_index == 3:
		_sheath()
	elif attack_index > 0:
		$ComboTimer.start(.2)
		attacking = false


func _on_combo_timer_timeout() -> void:
	_sheath()
	$ComboTimer.stop()
