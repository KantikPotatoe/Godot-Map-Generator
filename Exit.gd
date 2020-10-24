extends Area2D

signal leave_level

func _on_Exit_body_entered(body):
	emit_signal("leave_level")
