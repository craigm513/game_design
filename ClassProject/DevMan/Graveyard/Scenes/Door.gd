extends Area2D


export(String,FILE,"*.TSCN") var target_stage



func _on_Area2D_body_entered(body):
	if "PLAYER" in body.name:
		get_tree().change_scene(target_stage)
