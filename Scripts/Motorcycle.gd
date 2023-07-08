extends Car

@export var motorcycleSpeed = 150
@export var motorcycleDmg = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	speed = motorcycleSpeed
	damage = motorcycleDmg
