extends Area2D

@onready var timer: Timer = $Timer
@onready var die_sfx: AudioStreamPlayer2D = $DieSFX
var death_screen: Panel

func _ready():
	death_screen = get_tree().get_first_node_in_group("death_screen")
	if death_screen == null:
		print("WARNING!! Death Screen is null")

func _on_body_entered(body) -> void:
	death_screen.visible = true
	die_sfx.play()
	Engine.time_scale = 0.4
	timer.start()
	print(body.name)
	body.die()	

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	GameManager.reset_score()
