extends Animal

var newDist = 50
var newInterval = 2
var newSteps = 1
var newWeight = 0.14
var newHealth = 5
var newPoints = 100

var newVariance = 10

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
