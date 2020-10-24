extends Node
class_name Walker

const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]

var position = Vector2.ZERO
var direction = Vector2.RIGHT

var borders = Rect2()

var stepHistory = []
var stepsSinceTurn = 0

# ----- Parameters Option ----- #
var maxStepsSinceTurn = 6
var changeDirectionChance = 0.25
var useDirectionChange = true

var rooms = []

func _init(p_startingPosition, p_newBorder, p_maxStepsSinceTurn, p_changeDirectionChance, p_useDirectionChange):
	
	assert(p_newBorder.has_point(p_startingPosition)) #check if starting point is inside borders
	maxStepsSinceTurn = p_maxStepsSinceTurn
	stepsSinceTurn = p_maxStepsSinceTurn
	position = p_startingPosition
	useDirectionChange = p_useDirectionChange
	changeDirectionChance = p_changeDirectionChance
	stepHistory.append(position)
	borders = p_newBorder
	
	
func walk(steps):
	place_room(position)
	for step in steps:
		if useDirectionChange:
			if randf() <= changeDirectionChance and stepsSinceTurn >= maxStepsSinceTurn:
				changeDirection()
		else:
			if stepsSinceTurn >= maxStepsSinceTurn:
				changeDirection()
		if step():
			stepHistory.append(position)
		else:
			changeDirection()
	return stepHistory
	
func step():
	var targetPosition = position + direction
	if borders.has_point(targetPosition):
		stepsSinceTurn += 1
		position = targetPosition
		return true
	else:
		return false
	
func changeDirection():
	place_room(position)
	stepsSinceTurn = 0
	var directions = DIRECTIONS.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front()
	while not borders.has_point(position + direction):
		direction = directions.pop_front()
		


func create_room(position, size):
	return {position = position, size = size}

func place_room(p_position):
	var size = Vector2(randi() % 4 + 2, randi() % 4 + 2)
	var topLeftCorner = (p_position - size / 2).ceil()
	rooms.append(create_room(position, size))
	for y in size.y:
		for x in size.x:
			var newStep = topLeftCorner + Vector2(x,y)
			if borders.has_point(newStep):
				stepHistory.append(newStep)

func generate_end_room():
	var end_room = rooms.pop_front()
	var starting_position = stepHistory.front()
	for room in rooms:
		if starting_position.distance_to(room.position) > starting_position.distance_to(end_room.position):
			end_room = room
	return end_room
