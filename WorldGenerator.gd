extends Node2D

var borders = Rect2(1, 1, 76, 42)



onready var tileMap = $TileMap



onready var maxStepsSinceTurn = Vars.maxStepsSinceTurn
onready var changeDirectionChance = Vars.changeDirectionChance
onready var useDirectionChange = Vars.useDirectionChange
onready var numberOfSteps = Vars.numberOfSteps
onready var randomizeSeed = Vars.randomizeSeed

func _ready():
	
	if randomizeSeed :
		randomize()
	
	generateLevel()
	
func generateLevel():
	var walker = Walker.new(Vector2(38,21), borders, maxStepsSinceTurn, changeDirectionChance, useDirectionChange)
	var map = walker.walk(numberOfSteps)
	walker.queue_free()
	for location in map:
		tileMap.set_cellv(location, -1)
	tileMap.update_bitmask_region(borders.position, borders.end)

func reloadLevel():
	get_tree().reload_current_scene()




func _on_Direction_pressed():
	useDirectionChange = $GUI/MarginContainer/Panel/VBoxContainer/Direction.pressed
	Vars.useDirectionChange = useDirectionChange
	


func _on_Randomize_pressed():
	randomizeSeed = $GUI/MarginContainer/Panel/VBoxContainer/Randomize.pressed
	Vars.randomizeSeed = randomizeSeed


func _on_Button_pressed():
	reloadLevel()


func _on_Max_step_value_changed(value):
	maxStepsSinceTurn = value
	Vars.maxStepsSinceTurn = maxStepsSinceTurn


func _on_Turn_chance_value_changed(value):
	changeDirectionChance = value
	Vars.changeDirectionChance = changeDirectionChance


func _on_Number_of_steps_value_changed(value):
	numberOfSteps = value
	Vars.numberOfSteps = numberOfSteps


func _on_Preset1_pressed():
	maxStepsSinceTurn = 4
	changeDirectionChance = 0.25 
	useDirectionChange  = true
	numberOfSteps = 500
	randomizeSeed = true
	Vars.maxStepsSinceTurn = maxStepsSinceTurn
	Vars.changeDirectionChance = changeDirectionChance
	Vars.useDirectionChange = useDirectionChange
	Vars.numberOfSteps = numberOfSteps
	Vars.randomizeSeed = randomizeSeed
	reloadLevel()


func _on_Preset2_pressed():
	maxStepsSinceTurn = 7
	changeDirectionChance = 0.10
	useDirectionChange  = true
	numberOfSteps = 800
	randomizeSeed = true
	Vars.maxStepsSinceTurn = maxStepsSinceTurn
	Vars.changeDirectionChance = changeDirectionChance
	Vars.useDirectionChange = useDirectionChange
	Vars.numberOfSteps = numberOfSteps
	Vars.randomizeSeed = randomizeSeed
	reloadLevel()


func _on_Preset3_pressed():
	maxStepsSinceTurn = 3
	changeDirectionChance = 0.5
	useDirectionChange  = false
	numberOfSteps = 1000
	randomizeSeed = true
	Vars.maxStepsSinceTurn = maxStepsSinceTurn
	Vars.changeDirectionChance = changeDirectionChance
	Vars.useDirectionChange = useDirectionChange
	Vars.numberOfSteps = numberOfSteps
	Vars.randomizeSeed = randomizeSeed
	reloadLevel()
