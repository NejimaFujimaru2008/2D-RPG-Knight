extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300
var dead := false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sfx: AudioStreamPlayer2D = $JumpSFX
@onready var attack_sfx: AudioStreamPlayer2D = $AttackSFX

# New variable to track whether we are attacking
var attacking = false

func _ready():
	# Connect the animation_finished signal
	animated_sprite.animation_finished.connect(_on_animated_sprite_animation_finished)

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not dead:
		velocity.y = JUMP_VELOCITY
		jump_sfx.play()

	var direction := Input.get_axis("ui_left", "ui_right")

	# Flip sprite based on direction
	if not dead:
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true

	# Handle input only when not attacking
	if not attacking and not dead:
		if Input.is_action_just_pressed("attack"):
			attacking = true
			animated_sprite.play("attack")
			attack_sfx.play()
		else:
			# Movement animations
			if is_on_floor() and not dead:
				if direction == 0:
					animated_sprite.play("Idle")
				else:
					animated_sprite.play("run")
			else:
				# In air – use jump animation
				animated_sprite.play("jump")

	# Apply horizontal movement
	if direction and not dead:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# This is a separate method, not inside _physics_process
func _on_animated_sprite_animation_finished():
	if animated_sprite.animation == "attack":
		attacking = false

func die():
	dead = true
	animated_sprite.play("die")
