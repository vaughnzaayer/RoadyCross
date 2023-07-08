extends Animal

var newDist = 12
var newInterval = 0.5
var newSteps = 3
var newWeight = 0.2
var newHealth = 3
var newPoints = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	moveDistance = newDist
	moveInterval = newInterval
	stepsPerMovement = newSteps
	lerpWeight = newWeight
	health = newHealth
	points = newPoints
