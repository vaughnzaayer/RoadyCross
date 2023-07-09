extends Car

@export var motorcycleSpeed = 150
@export var motorcycleDmg = 1
@export var motorcycleCooldown = 1.5


# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	speed = motorcycleSpeed
	damage = motorcycleDmg
	cooldown = motorcycleCooldown
