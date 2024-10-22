extends TextureProgressBar

@export var oryx: Oryx

func _ready():
	oryx.health_changed.connect(update)
	update()
	
func update():
	value = oryx.health * 100 / oryx.maxHealth
