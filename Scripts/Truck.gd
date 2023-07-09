extends Car

@export var truckSpeed = 15
@export var truckDmg = 25
@export var truckCooldown = 7.5


# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	speed = truckSpeed
	damage = truckDmg
	cooldown = truckCooldown
