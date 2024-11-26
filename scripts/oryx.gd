extends CharacterBody2D

class_name Oryx

signal health_changed
signal health_depleted
var maxHealth=800
var health=800
var player
var has_executed: bool = false
var is_first_iteration = true
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var aim = $Aim
@onready var move_timer: Timer = $MoveTimer
@onready var move_timer2: Timer = $MoveTimer2
@export var jump_speed: float = 2500.0  # Adjust as needed
@export var paralyze_count: int = 24
@export var slash_count: int = 72
@export var slash_repeats: int = 10
@export var slash_interval: float = 0.1
@export var delay_between_phases: float = 2.5

var is_jumping: bool = false
func _ready():
	player = get_node("/root/Game/Player")

func _physics_process(delta: float) -> void:
	if !has_executed:
		var direction = global_position.direction_to(player.global_position)
		if health>maxHealth/2:
			velocity = direction * 25
		else:
			has_executed=true
			start_process()
			
		move_and_slide()
	
func start_process() -> void:
	while health > 0:
		if is_first_iteration:
			print("Initial delay of 0.2 seconds")
			await delay(1.0)
			is_first_iteration = false

		print("Executing jump_to_player")
		if not await jump_to_player():
			print("Health depleted during jump_to_player")
			return

		print("Executing create_paralyze")
		if not await create_paralyze():
			print("Health depleted during create_paralyze")
			return

		print("Executing create_slashes")
		if not await create_slashes():
			print("Health depleted during create_slashes")
			return

		print("Waiting before next loop")
		if not await delay(delay_between_phases):
			print("Health depleted during delay")
			return

		print("Exiting start_process due to health reaching 0")

func jump_to_player() -> bool:
	if health <= 0:
		return false
	if player:
		is_jumping = true
		var direction = (player.global_position - global_position).normalized()
		global_position += direction * jump_speed * 0.016
		is_jumping = false
	await delay(0.01)  # Brief pause after jump
	return true

func create_paralyze() -> bool:
	if health <= 0:
		return false
	var shooting_point = aim.get_node("Point/AnimatedSprite2D/ShootingPoint")
	const PARALYZE = preload("res://scenes/paralyze.tscn")
	if shooting_point:
		for i in range(paralyze_count):
			var angle = deg_to_rad(i * 15)  # Calculate angle in radians (30 degrees apart)
			var paralyze_instance = PARALYZE.instantiate()
			# Position and rotate the paralyze instance
			paralyze_instance.global_position = shooting_point.global_position
			paralyze_instance.rotation = angle
			# Add it as a child of aim
			aim.add_child(paralyze_instance)
		
	await delay(3.0)  # Wait for 3 seconds after creating paralyze instances
	return true
	
func create_slashes() -> bool:
	if health <= 0:
		return false
	var shooting_point = aim.get_node("Point/AnimatedSprite2D/ShootingPoint")
	const SLASH = preload("res://scenes/slash.tscn")
	if shooting_point:
		for repeat in range(slash_repeats):
			for i in range(slash_count):
				var angle = deg_to_rad(i * 5)  # Calculate angle in radians (15 degrees apart)
				var slash_instance = SLASH.instantiate()
					
				# Position and rotate the slash instance
				slash_instance.global_position = shooting_point.global_position
				slash_instance.rotation = angle
					
				# Add it as a child of aim
				aim.add_child(slash_instance)
				
			await delay(slash_interval)  # Wait between slash groups
	return true

func delay(seconds: float) -> bool:
	if health <= 0:
			return false
	await get_tree().create_timer(seconds).timeout
	return true
	
func take_damage():
	health-=10
	health_changed.emit()
	animation_player.play("oryx_hit")
	if health<=0:
		var shooting_point = aim.get_node("Point/AnimatedSprite2D/ShootingPoint")
		const DRUNK = preload("res://scenes/drunk.tscn")
		var drunk_instance = DRUNK.instantiate()
		drunk_instance.global_position = shooting_point.global_position
		drunk_instance.rotation = aim.rotation
		aim.add_child(drunk_instance)
		health_depleted.emit()
		animation_player.play("oryx_death")
		$TextureProgressBar.queue_free()
		animation_player.connect("animation_finished", Callable(self, "_on_animation_finished"))	

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "oryx_death":
		get_tree().change_scene_to_file("res://scenes/win.tscn")
