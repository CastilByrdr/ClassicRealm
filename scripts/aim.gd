extends Area2D

var player
var oryx
var has_executed: bool = false
@onready var attack_timer: Timer = $AttackTimer
@onready var attack_timer2: Timer = $AttackTimer2

func _ready():
	player = get_node("/root/Game/Player")
	oryx = get_node("/root/Game/Oryx") as Oryx
	
func _physics_process(delta: float) -> void:
	if player:
		var player_position = player.global_position
		var current_position = global_position
		var direction = player_position - current_position
		rotation = direction.angle()

func shoot():
	const SLASH = preload("res://scenes/slash.tscn")
	const SLOW = preload("res://scenes/slow.tscn")
	const PARALYZE = preload("res://scenes/paralyze.tscn")
	var new_slash = SLASH.instantiate()
	var new_slash2 = SLASH.instantiate()
	var new_slash3 = SLASH.instantiate()
	new_slash.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position 
	new_slash2.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position
	new_slash3.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position
	new_slash.rotation = self.rotation
	new_slash2.rotation = self.rotation+45
	new_slash3.rotation = self.rotation-45
	$Point/AnimatedSprite2D/ShootingPoint.add_child(new_slash) 
	$Point/AnimatedSprite2D/ShootingPoint.add_child(new_slash2) 
	$Point/AnimatedSprite2D/ShootingPoint.add_child(new_slash3) 
	if oryx.health>oryx.maxHealth/2:
		var new_slow = SLOW.instantiate()
		new_slow.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position 
		new_slow.rotation = self.rotation
		$Point/AnimatedSprite2D/ShootingPoint.add_child(new_slow) 
	else:
		if not has_executed:
			attack_timer.queue_free()
			attack_timer2.start()
			has_executed=true
		var new_paralyze = PARALYZE.instantiate()
		var new_paralyze2 = PARALYZE.instantiate()
		var new_paralyze3 = PARALYZE.instantiate()
		var new_paralyze4 = PARALYZE.instantiate()
		var new_paralyze5 = PARALYZE.instantiate()
		var new_paralyze6 = PARALYZE.instantiate()
		var new_paralyze7 = PARALYZE.instantiate()
		var new_paralyze8 = PARALYZE.instantiate()
		var new_paralyze9 = PARALYZE.instantiate()
		var new_paralyze10 = PARALYZE.instantiate()
		var new_paralyze11 = PARALYZE.instantiate()
		var new_paralyze12 = PARALYZE.instantiate()
		new_paralyze.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position 
		new_paralyze2.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position
		new_paralyze3.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position
		new_paralyze4.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position
		new_paralyze5.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position
		new_paralyze6.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position
		new_paralyze7.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position
		new_paralyze8.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position
		new_paralyze9.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position
		new_paralyze10.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position
		new_paralyze11.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position
		new_paralyze12.global_position = $Point/AnimatedSprite2D/ShootingPoint.global_position
		new_paralyze.rotation = self.rotation
		new_paralyze2.rotation = self.rotation+30
		new_paralyze3.rotation = self.rotation+60
		new_paralyze4.rotation = self.rotation+90
		new_paralyze5.rotation = self.rotation+120
		new_paralyze6.rotation = self.rotation+150
		new_paralyze7.rotation = self.rotation+180
		new_paralyze8.rotation = self.rotation+210
		new_paralyze9.rotation = self.rotation+240
		new_paralyze10.rotation = self.rotation+270
		new_paralyze11.rotation = self.rotation+300
		new_paralyze12.rotation = self.rotation+330
		$Point/AnimatedSprite2D/ShootingPoint.add_child(new_paralyze) 
		$Point/AnimatedSprite2D/ShootingPoint.add_child(new_paralyze2) 
		$Point/AnimatedSprite2D/ShootingPoint.add_child(new_paralyze3) 
		$Point/AnimatedSprite2D/ShootingPoint.add_child(new_paralyze4) 
		$Point/AnimatedSprite2D/ShootingPoint.add_child(new_paralyze5) 
		$Point/AnimatedSprite2D/ShootingPoint.add_child(new_paralyze6) 
		$Point/AnimatedSprite2D/ShootingPoint.add_child(new_paralyze7) 
		$Point/AnimatedSprite2D/ShootingPoint.add_child(new_paralyze8) 
		$Point/AnimatedSprite2D/ShootingPoint.add_child(new_paralyze9) 
		$Point/AnimatedSprite2D/ShootingPoint.add_child(new_paralyze10) 
		$Point/AnimatedSprite2D/ShootingPoint.add_child(new_paralyze11) 
		$Point/AnimatedSprite2D/ShootingPoint.add_child(new_paralyze12) 
		

func _on_attack_timer_timeout() -> void:
	shoot()

func _on_attack_timer_2_timeout() -> void:
	shoot()
