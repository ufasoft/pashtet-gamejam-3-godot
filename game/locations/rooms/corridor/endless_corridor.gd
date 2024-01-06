extends Node2D


@onready var left_marker = $LeftMarker
@onready var right_marker = $RightMarker

@onready var light = $Light
@onready var e_label = $Light/ELabel


const LIGHT_ON = preload("res://assets/light_on.png")
const LIGHT_OFF = preload("res://assets/light_off.png")


var rng := RandomNumberGenerator.new()

var corridors := []
var current_index := 0

func _ready():
	rng.randomize()
	seed(rng.seed)
	
	for i in randi_range(5, 10):
		corridors.append(1)





func switch_light():
	if corridors[current_index] == 1:
		corridors[current_index] = 0
		turn_off_light()
	else:
		corridors[current_index] = 1
		turn_on_light()

func turn_on_light():
	light.texture = LIGHT_ON
	modulate = Color("ffffff")
	corridors[current_index] = 1

func turn_off_light():
	light.texture = LIGHT_OFF
	modulate = Color("404040")
	corridors[current_index] = 0

func check_light():
	if corridors[current_index] == 1:
		turn_on_light()
	else:
		turn_off_light()



func _on_left_door_body_entered(body):
	body.position = right_marker.position
	if current_index == 0:
		current_index = corridors.size() - 1
	else:
		current_index -= 1
	
	check_light()

func _on_right_door_body_entered(body):
	body.position = left_marker.position
	if current_index == corridors.size() - 1:
		current_index = 0
	else:
		current_index += 1
	
	check_light()






func _on_area_2d_body_entered(body):
	e_label.visible = true


func _on_area_2d_body_exited(body):
	e_label.visible = false


func _input(event):
	if Input.is_action_just_pressed("action") and e_label.visible:
		switch_light()
		
		
		
