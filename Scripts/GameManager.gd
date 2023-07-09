extends Node2D

var score = 0
var time = 120

@export var sedanCdTime = 3.0
@export var motorcycleCdTime = 1.5
@export var truckCdTime = 7.5

@onready var gameTimer = $Timer
@onready var sedanCooldownTimer = $SedanCooldownTimer
@onready var motorcycleCooldownTimer = $MotorcycleCooldownTimer
@onready var truckCooldownTimer = $TruckCooldownTimer

@onready var spawner = get_tree().get_root().get_node_or_null("Game/AnimalSpawner")
@onready var UI = get_tree().get_root().get_node_or_null("Game/GameUI")

var state = states.IDLE
var prevState

var currentCar = carSelection.SEDAN
var sedanAvailable = true
var motorcycleAvailable = true
var truckAvailable = true

enum states {
	IDLE,
	ACTIVE,
	END
}

enum carSelection {
	SEDAN,
	MOTORCYCLE,
	TRUCK
}

# Called when the node enters the scene tree for the first time.
func _ready():
	gameTimer.timeout.connect(Callable(self, "GameTimeout"))
	gameTimer.wait_time = time
	gameTimer.one_shot = true
	
	sedanCooldownTimer.timeout.connect(Callable(self, "SedanReady"))
	sedanCooldownTimer.wait_time = sedanCdTime
	sedanCooldownTimer.one_shot = true
	
	motorcycleCooldownTimer.timeout.connect(Callable(self, "MotorcycleReady"))
	motorcycleCooldownTimer.wait_time = motorcycleCdTime
	motorcycleCooldownTimer.one_shot = true
	
	truckCooldownTimer.timeout.connect(Callable(self, "TruckReady"))
	truckCooldownTimer.wait_time = truckCdTime
	truckCooldownTimer.one_shot = true
	
	SaveData.Load()
	
	await get_tree().process_frame
	
	if is_instance_valid(UI) and is_instance_valid(spawner):
		ChangeState(states.IDLE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#DebugInput()
	pass

# press Z to automatically start a new game, for debug purposes
func DebugInput():
	if Input.is_action_just_pressed("ui_debug1"):
		StartGame()

# changes state
func ChangeState(newState):
	prevState = state
	state = newState
	
	EnterState(state)

# triggered when state is changed
func EnterState(newState):
	match newState:
		states.IDLE:
			Idle()
		states.ACTIVE:
			StartGame()
		states.END:
			EndGame()

# starts a new game
func StartGame():
	# reset score
	# clear remaining animals from the playing field
	# activate spawner
	# toggle gameplay UI
	score = 0
	gameTimer.start()
	spawner.ClearAnimals()
	spawner.Activate()
	UI.ChangeState(UI.states.GAMEPLAY)

# ends the currently active game
func EndGame():
	# deactivate spawner
	# toggle endscreen UI
	spawner.Deactivate()
	UI.ChangeState(UI.states.ENDSCREEN)
		
func UpdateHS():
	SaveData.highscore = score
	SaveData.Save()

# returns to the main menu
func Idle():
	# toggle menu UI
	UI.ChangeState(UI.states.IDLE)

# adds score to the total
func AddScore(amount):
	score += amount

# triggered when the game timer ends
# ends the current active game
func GameTimeout():
	ChangeState(states.END)

func SedanCooldown():
	sedanAvailable = false
	sedanCooldownTimer.start()

func SedanReady():
	sedanAvailable = true

func MotorcycleCooldown():
	motorcycleAvailable = false
	motorcycleCooldownTimer.start()

func MotorcycleReady():
	motorcycleAvailable = true

func TruckCooldown():
	truckAvailable = false
	truckCooldownTimer.start()

func TruckReady():
	truckAvailable = true

