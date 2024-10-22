extends Control


@onready var animation_player: AnimationPlayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time
func _ready():
	animation_player = $AnimationPlayer  # Reference the AnimationPlayer
	$Button.text = "Restart"
	$Label.text = "Oryx is defeated. You feel stronger."
	# Correctly use Callable for connecting the button's signal
	$Button.connect("pressed", Callable(self, "_on_restart_button_pressed"))
	animation_player.play("win")


func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")
