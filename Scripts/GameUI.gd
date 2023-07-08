extends Control

@onready var gameplayInfo = $MarginContainer/GameplayInfo
@onready var scoreDisplay = $MarginContainer/GameplayInfo/ScoreDisplay
@onready var timeDisplay = $MarginContainer/GameplayInfo/TimeDisplay

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
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		states.IDLE:
			pass
		states.GAMEPLAY:
			scoreDisplay.text = str(GameManager.score)
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
	
	startButton.disabled = false
	quitButton.disabled = false
	returnButton.disabled = true

func GameplayMode():
	mainMenu.visible = false
	gameplayInfo.visible = true
	endscreen.visible = false
	
	startButton.disabled = true
	quitButton.disabled = true
	returnButton.disabled = true

func EndscreenMode():
	mainMenu.visible = false
	gameplayInfo.visible = false
	endscreen.visible = false
	
	startButton.disabled = true
	quitButton.disabled = true
	returnButton.disabled = false
	
func CalculateTime():
	var rawTime = GameManager.gameTimer.get_time_left()
	
	var minutes = floori(rawTime / 60)
	var seconds = floori(rawTime - (minutes * 60))
	
	return str(minutes) + ":" + str(seconds)
