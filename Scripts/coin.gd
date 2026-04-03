extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body) -> void:
	GameManager.add_point()
	animation_player.play("pickup")
	print(body.name + " "+ "picked a coin up")
