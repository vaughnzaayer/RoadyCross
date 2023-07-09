extends Car

@export var sedanSpeed = 50
@export var sedanDmg = 5
@export var sedanCooldown = 3.0


# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	speed = sedanSpeed
	damage = sedanDmg
	cooldown = sedanCooldown
