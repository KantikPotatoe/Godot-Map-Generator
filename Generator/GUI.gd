extends Control


func _ready():
		$MarginContainer/Panel/VBoxContainer/Direction.pressed = Vars.useDirectionChange
		$MarginContainer/Panel/VBoxContainer/Randomize.pressed = Vars.randomizeSeed
		$"MarginContainer/Panel/VBoxContainer/Max step".value = Vars.maxStepsSinceTurn
		$"MarginContainer/Panel/VBoxContainer/Turn chance".value = Vars.changeDirectionChance
		$"MarginContainer/Panel/VBoxContainer/Number of steps".value = Vars.numberOfSteps
