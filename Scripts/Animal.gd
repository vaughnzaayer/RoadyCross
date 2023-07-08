class_name Animal extends Node2D

var moveDistance = 100
var moveInterval = 2
var stepsPerMovement = 1
var lerpWeight = 0.24

var health = 1
var points = 100

var movesLeft = 0

var safeDist = 0.05

@onready var moveTimer = $Timer
@onready var targetPosition = $Marker2D
@onready var collision = $Area2D

var state = states.IDLE
var prevState = null

enum states {
	MOVING,
	IDLE
}

func bruh(dist, interval, steps, health, points):
	moveDistance = dist
	moveInterval = interval
	stepsPerMovement = steps
	self.health = health
	self.points = points
	
	moveTimer.timeout.connect(Callable(self, "MoveTimeout"))
	
	moveTimer.wait_time = moveInterval
	moveTimer.one_shot = true
	
	ChangeState(states.IDLE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		states.MOVING:
			global_position.y = lerp(global_position.y, targetPosition.global_position.y, lerpWeight)
			global_position.x = lerp(global_position.x, targetPosition.global_position.x, lerpWeight)
			
			if global_position.distance_squared_to(targetPosition.global_position) <= safeDist:
				global_position = targetPosition.global_position
				print("reached target")
				
				if movesLeft > 0:
					Move()
				else:
					ChangeState(states.IDLE)
		states.IDLE:
			pass
	
func ChangeState(newState):
	prevState = state
	state = newState
	
	EnterState(newState)
	
func EnterState(enteredState):
	match enteredState:
		states.IDLE:
			moveTimer.start()
		states.MOVING:
			Move()
	
func Move():
	var calcMovement = moveDistance/stepsPerMovement
	targetPosition.global_position = global_position + Vector2(0, -calcMovement)
	movesLeft -= 1
	
func MoveTimeout():
	print("dumbass")
	movesLeft = stepsPerMovement
	ChangeState(states.MOVING)
