extends Animal

var newDist = 50
var newInterval = 2
var newSteps = 1
var newWeight = 0.14
var newHealth = 1
var newPoints = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	moveDistance = newDist
	moveInterval = newInterval
	stepsPerMovement = newSteps
	lerpWeight = newWeight
	health = newHealth
	points = newPoints
