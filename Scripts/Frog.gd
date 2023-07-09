extends Animal

var newDist = 64
var newInterval = 3
var newSteps = 1
var newWeight = 0.1
var newHealth = 5
var newPoints = 200

var newVariance = 12

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	moveDistance = newDist
	moveInterval = newInterval
	stepsPerMovement = newSteps
	lerpWeight = newWeight
	health = newHealth
	points = newPoints
	
	xVariance = newVariance
