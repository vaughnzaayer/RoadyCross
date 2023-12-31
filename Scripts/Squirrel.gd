extends Animal

var newDist = 48
var newInterval = 0.7
var newSteps = 2
var newWeight = 0.24
var newHealth = 3
var newPoints = 150

var newVariance = 8
var newVarianceFlag = true

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
	variancePerStep = newVarianceFlag
