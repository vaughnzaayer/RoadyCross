class_name Animal extends Node2D

# moveDistance: movement per movement opportunity
# moveInterval: time between movement opportunities
# stepsPerMovement: amount of steps to split movement distance into
# lerpWeight: snappiness of animal movement
# lerpWeight is a float from 0-1, 0 = no movement, 1 = near instant movement
# xVariance is the range of random X axis movement an animal can have
# variancePerStep is a flag that decides whether an animal has new variance for each step, or set variance for each movement opportunity
# currentVariance is an internal variable used to store the x variance during a movement opportunity

var moveDistance = 50
var moveInterval = 2
var stepsPerMovement = 1
var lerpWeight = 0.14

var xVariance = 5
var variancePerStep = false

var currentVariance = 0

# health: the damage an animal can take before dying
# points: the amount of points this animal grants to the player upon dying

var health = 1
var points = 100

# movesLeft: an internal variable used for step movement, counts how many steps are left in the current movement opportunity
# safeDist: the distance (squared) that the animal must be within their target position for their step to count as a successful step

var movesLeft = 0
var safeDist = 1

# moveTimer: the animal's internal timer that tells it when to move
# targetPosition: the animal's target position. updated at the start of every step, and the animal will then start to move towards it.
# collision: the animal's Area2D that tells it when it's collided with something
# audio: the animal's audio library
# collidingWith: an array of all areas currently colliding with the animal

@onready var moveTimer = $Timer
var targetPosition = Vector2.ZERO
@onready var collision = $Area2D
@onready var audio = $AudioLibrary
@onready var anim = $AnimationPlayer

var collidingWith = []

# state: the animal's current state, used in the animal's FSM
# prevState: the previous state the animal was in. idk when this will be useful but I made it anyways just in case
# states: an enum containing all of the possible states an animal can be in

var state = states.IDLE
var prevState = null

enum states {
	MOVING,
	IDLE,
	DEAD
}

func _ready():
	moveTimer.timeout.connect(Callable(self, "MoveTimeout"))
	
	moveTimer.wait_time = moveInterval
	moveTimer.one_shot = true
	
	collision.area_entered.connect(Callable(self, "AreaEntered"))
	collision.area_exited.connect(Callable(self, "AreaExited"))
	
# call Spawn after instancing an animal to "activate" them.
# unique animal variables are set in their subclass scripts
func Spawn(pos):
	global_position = pos
	moveTimer.wait_time = moveInterval
	
	ChangeState(states.IDLE)

# this is where the bulk of the animal FSM is contained
func _process(_delta):
	match state:
		states.MOVING:
			# move towards target position
			global_position.x = lerp(global_position.x, targetPosition.x, lerpWeight)
			global_position.y = lerp(global_position.y, targetPosition.y, lerpWeight)
			
			# when target is reached, take next step or idle again if out of steps
			if global_position.distance_squared_to(targetPosition) <= safeDist:
				global_position = targetPosition
				#print("reached target")
				
				if movesLeft > 0:
					if variancePerStep:
						currentVariance = CalculateVariance()
					Move()
				else:
					ChangeState(states.IDLE)
					
		states.IDLE:
			if global_position.y < -16:
				queue_free()
	
# function used to change an animal's state
func ChangeState(newState):
	prevState = state
	state = newState
	
	EnterState(newState)

# function called every time the animal changes state
func EnterState(enteredState):
	match enteredState:
		states.IDLE:
			moveTimer.start()
			anim.play("Idle")
		states.MOVING:
			Move()
			anim.play("Move")
		states.DEAD:
			Die()
	
# calculates target position and steps remaining
func Move():
	var calcMovement = float(moveDistance)/stepsPerMovement
	targetPosition = global_position + Vector2(currentVariance, -calcMovement)
	movesLeft -= 1
	
	#print("current pos: ", global_position)
	#print("target pos: ", targetPosition)
	#print("moves left ", movesLeft)

# called once the movement timer runs out
# sets steps remaining and kicks off the movement loop
func MoveTimeout():
	movesLeft = stepsPerMovement
	currentVariance = CalculateVariance()
	ChangeState(states.MOVING)
	
# returns a random x variance value
func CalculateVariance():
	return randf_range(-xVariance, xVariance)

# function called to make animals take damage, also kills animals that reach 0 hp
func TakeDamage(amount):
	health -= amount
	
	if health <= 0:
		ChangeState(states.DEAD)
	else:
		audio.Play("Hit")

# called when the animal dies
func Die():
	GameManager.AddScore(points)
	moveTimer.stop()
	audio.PlayOnly("Die")
	anim.play("Die")
	collision.set_deferred("monitoring", false)
	collision.set_deferred("monitorable", false)
	
# adds an area to the list of collisions, takes damage if it's a car
func AddCollision(area):
	collidingWith.append(area)
	
	if area.get_collision_layer_value(2):
		TakeDamage(area.get_parent().damage)

# removes an area from the list of collisions
func RemoveCollision(area):
	collidingWith.erase(area)

# detects when an area collides with the animal and adds it to the list of collisions
func AreaEntered(area):
	AddCollision(area)

# detects when an area stops colliding with the animal and removes it from the list of collisions
func AreaExited(area):
	RemoveCollision(area)
