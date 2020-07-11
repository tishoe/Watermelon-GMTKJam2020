extends "res://Entities/abstracts/Moveable.gd"

var next_movement = null
var reached_goal = false

var move_count
var move_limit
var forced_moves
var direction

func _ready():
	var data = get_node("/root/LevelData").get_level_data()
	move_count = 0
	move_limit = data["total_moves"]
	forced_moves = data["forced_moves"]
	$AnimatedSprite.play("default")

func _input(event):
	if !moving:
		if event.is_action_pressed("ui_right"):
			start_moving(Vector2.RIGHT)
		if event.is_action_pressed("ui_left"):
			start_moving(Vector2.LEFT)
		if event.is_action_pressed("ui_up"):
			start_moving(Vector2.UP)
		if event.is_action_pressed("ui_down"):
			start_moving(Vector2.DOWN)
	elif next_movement == null:
		if event.is_action_pressed("ui_right"):
			next_movement = Vector2.RIGHT
		if event.is_action_pressed("ui_left"):
			next_movement = Vector2.LEFT
		if event.is_action_pressed("ui_up"):
			next_movement = Vector2.UP
		if event.is_action_pressed("ui_down"):
			next_movement = Vector2.DOWN
		
		
func start_moving(dir:Vector2):
	if move_count >= move_limit:
		# add a thing to the UI which makes you restart
		return
	decrement_counter()
	self.direction = possible_forced_direction(move_count, dir)
	.start_moving(self.direction)
	
func possible_forced_direction(moves_left, dir):
	if moves_left in forced_moves.keys():
		return forced_moves[moves_left]
	return dir
	
func decrement_counter():
	get_node("/root/UI").decrement_counter()
	move_count += 1
	
func _physics_process(delta):
	if moving:
		moving = move()
		if !moving and next_movement != null:
			start_moving(next_movement)
			next_movement = null
			
func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "death":
		get_node("/root/LevelLoader").restart_level()

func _on_body_entered(body):
	match body.collision_layer:
		2: # wall
			reversal_move()
			moving = false
			return true
		4: # water
			$AnimatedSprite.play("death")
			move_count = move_limit
		64: # goal
			if !reached_goal:
				get_node("../Goal/AnimationPlayer").play("eaten")
				get_node("/root/LevelLoader").finished_level()
				reached_goal = true

func _on_area_entered(area):
	match area.collision_layer:
		2: # "wall" (box became layer 2 probs)
			reversal_move()
			moving = false
			return true
		8: #box
			area.start_moving(self.direction)
		16: # arrows
			next_movement = area.get_direction()
