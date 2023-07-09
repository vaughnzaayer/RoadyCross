extends Sprite2D

var blinking = false
@onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Blink():
	anim.play("Blink")
