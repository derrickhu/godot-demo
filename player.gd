extends CharacterBody2D
const SPEED = 300
func _physics_process(delta):
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = dir.normalized() * SPEED
	move_and_slide()
