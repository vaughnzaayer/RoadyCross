extends Control

@onready var gameplayInfo = $MarginContainer/GameplayInfo
@onready var scoreDisplay = $MarginContainer/GameplayInfo/ScoreDisplay
@onready var timeDisplay = $MarginContainer/GameplayInfo/TimeDisplay
@onready var carSelect = $MarginContainer/CarSelection
@onready var selectSedan = $MarginContainer/CarSelection/SelectSedan
@onready var selectMotorcycle = $MarginContainer/CarSelection/SelectMotorcycle
@onready var selectTruck = $MarginContainer/CarSelection/SelectTruck


@onready var mainMenu = $MarginContainer/Title
@onready var endscreen = $MarginContainer/Endscreen

@onready var startButton = $MarginContainer/Title/VBoxContainer/StartButton
@onready var quitButton = $MarginContainer/Title/VBoxContainer/QuitButton
@onready var returnButton = $MarginContainer/Endscreen/VBoxContainer/ReturnButton

@onready var endscreenScore = $MarginContainer/Endscreen/VBoxContainer/VBoxContainer/Score
@onready var endscreenHSNotification = $MarginContainer/Endscreen/VBoxContainer/VBoxContainer/HighscoreText

@onready var titleHSText = $MarginContainer/Title/VBoxContainer/Highscore

var state = states.IDLE
var prevState

enum states {
	IDLE,
	GAMEPLAY,
	ENDSCREEN
}

# Called when the node enters the scene tree for the first time.
func _ready():
	startButton.pressed.connect(Callable(self, "StartPressed"))
	quitButton.pressed.connect(Callable(self, "QuitPressed"))
	returnButton.pressed.connect(Callable(self, "ReturnPressed"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		states.IDLE:
			pass
		states.GAMEPLAY:
			scoreDisplay.text = "Score: " + str(GameManager.score)
			timeDisplay.text = CalculateTime()
	
func ChangeState(newState):
	prevState = state
	state = newState
	
	EnterState(state)
	
func EnterState(newState):
	match newState:
		states.IDLE:
			IdleMode()
		states.GAMEPLAY:
			GameplayMode()
		states.ENDSCREEN:
			EndscreenMode()

func IdleMode():
	mainMenu.visible = true
	gameplayInfo.visible = false
	endscreen.visible = false
	carSelect.visible = false
	
	startButton.disabled = false
	quitButton.disabled = false
	returnButton.disabled = true
	selectSedan.disabled = true 
	selectMotorcycle.disabled = true
	selectTruck.disabled = true
	
	titleHSText.visible = false

func GameplayMode():
	mainMenu.visible = false
	gameplayInfo.visible = true
	endscreen.visible = false
	carSelect.visible = true
	
	startButton.disabled = true
	quitButton.disabled = true
	returnButton.disabled = true
	selectSedan.disabled = false 
	selectMotorcycle.disabled = false
	selectTruck.disabled = false

func EndscreenMode():
	mainMenu.visible = false
	gameplayInfo.visible = false
	endscreen.visible = true
	carSelect.visible = false
	
	startButton.disabled = true
	quitButton.disabled = true
	returnButton.disabled = false
	selectSedan.disabled = true 
	selectMotorcycle.disabled = true
	selectTruck.disabled = true
	
	endscreenHSNotification.visible = false
	endscreenScore.text = "Score: " + str(GameManager.score)
	
func CalculateTime():
	var rawTime = GameManager.gameTimer.get_time_left()
	
	var minutes = floori(rawTime / 60)
	var seconds = floori(rawTime - (minutes * 60))
	
	if seconds >= 10:
		return str(minutes) + ":" + str(seconds)
	else:
		return str(minutes) + ":0" + str(seconds)

func StartPressed():
	GameManager.ChangeState(GameManager.states.ACTIVE)
	
func QuitPressed():
	get_tree().quit()
	
func ReturnPressed():
	GameManager.ChangeState(GameManager.states.IDLE)
