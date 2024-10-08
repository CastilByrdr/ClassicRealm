extends Area2D

var travel_distance = 0

func _physics_process(delta: float) -> void:
	const SPEED=150
	const RANGE=125
	var direction =  Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	travel_distance += SPEED * delta
	if travel_distance>RANGE:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
