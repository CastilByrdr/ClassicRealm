extends Control

@export var fade_duration: float = 1.0  # Duration of the fade effect

var fade_rect: ColorRect  # Reference to the ColorRect

@onready var sound_animation_player: AnimationPlayer = $SoundAnimationPlayer
@onready var fade_player: AnimationPlayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time
func _ready():
	fade_rect = $ColorRect
	fade_player = $AnimationPlayer  # Reference the AnimationPlayer
	fade_rect.modulate.a = 0  # Start fully transparent
	fade_rect.show()  # Ensure the ColorRect is visible
	$Button.text = "Restart"
	$Label.text = "Game Over"
	# Correctly use Callable for connecting the button's signal
	$Button.connect("pressed", Callable(self, "_on_restart_button_pressed"))
	sound_animation_player.play("gameover")
	fade_in()
	
func fade_in():
	fade_player.play("fade_in")	
	
# Function to restart the game
func _on_restart_button_pressed():
	# Assuming "MainScene.tscn" is your game scene
	get_tree().change_scene_to_file("res://scenes/game.tscn")
