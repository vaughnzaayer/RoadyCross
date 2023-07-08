extends Node2D

var score = 0
var time = 120

@onready var gameTimer = $Timer

@onready var spawner = get_tree().get_root().get_node_or_null("Game/AnimalSpawner")
@onready var UI = get_tree().get_root().get_node_or_null("Game/GameUI")

var state = states.IDLE
var prevState

enum states {
	IDLE,
	ACTIVE,
	END
}

# Called when the node enters the scene tree for the first time.
func _ready():
	gameTimer.timeout.connect(Callable(self, "GameTimeout"))
	gameTimer.wait_time = time
	gameTimer.one_shot = true
	
	await get_tree().process_frame
	
	ChangeState(states.IDLE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	DebugInput()

func DebugInput():
	if Input.is_action_just_pressed("ui_debug1"):
		StartGame()

func ChangeState(newState):
	prevState = state
	state = newState
	
	EnterState(state)
	
func EnterState(newState):
	match newState:
		states.IDLE:
			Idle()
		states.ACTIVE:
			StartGame()
		states.END:
			EndGame()
	
func StartGame():
	score = 0
	gameTimer.start()
	spawner.ClearAnimals()
	spawner.Activate()
	UI.ChangeState(UI.states.GAMEPLAY)
	
func EndGame():
	spawner.Deactivate()
	UI.ChangeState(UI.states.ENDSCREEN)
	
func Idle():
	UI.ChangeState(UI.states.IDLE)
	
func AddScore(amount):
	score += amount

func GameTimeout():
	ChangeState(states.END)
