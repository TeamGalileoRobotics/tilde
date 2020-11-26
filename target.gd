extends "res://ball.gd"

func _on_body_collision(body):
	if(body.is_in_group("chasers")):
		print("collision")
		get_tree().reload_current_scene()
