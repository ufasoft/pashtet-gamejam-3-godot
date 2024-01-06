extends Node2D


@onready var left_marker = $LeftMarker
@onready var right_marker = $RightMarker

@onready var light = $Light


const LIGHT_ON = preload("res://assets/light_on.png")
const LIGHT_OFF = preload("res://assets/light_off.png")


var rng := RandomNumberGenerator.new()


var corridors := []
var current_corridor_index := 0


func _ready():
	rng.randomize()
	seed(rng.seed)

	for i in randi_range(5, 10):
		corridors.append(randi_range(0, 1))

func switch_light():
	if corridors[current_corridor_index] == 0:
		corridors[current_corridor_index] = 1
		light.turn_on_light()
	else:
		corridors[current_corridor_index] = 0
		light.turn_off_light()

func _input(event):
	if Input.is_action_just_pressed("action") and light.somebody_close:
		switch_light()

func _on_left_door_body_entered(body):
	body.position = right_marker.position

	if current_corridor_index == 0:
		current_corridor_index = corridors.size() - 1
	else:
		current_corridor_index -= 1

	light.check_light(corridors[current_corridor_index])

func _on_right_door_body_entered(body):
	body.position = left_marker.position

	if current_corridor_index == corridors.size() - 1:
		current_corridor_index = 0
	else:
		current_corridor_index += 1

	light.check_light(corridors[current_corridor_index])
