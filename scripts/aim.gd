extends Area2D

var player
@onready var attack_timer: Timer = $AttackTimer
func _ready():
	player = get_node("/root/Game/Player")
	
func _physics_process(delta: float) -> void:
	if player:
		var player_position = player.global_position
		var current_position = global_position
		var direction = player_position - current_position
		rotation = direction.angle()

func shoot():
	const SLOW = preload("res://scenes/slow.tscn")
	var new_slow = SLOW.instantiate()
	new_slow.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position 
	new_slow.rotation = self.rotation
	$Point/AnimatedSprite2D/ShootingPoint.add_child(new_slow) 

func _on_attack_timer_timeout() -> void:
	shoot()
