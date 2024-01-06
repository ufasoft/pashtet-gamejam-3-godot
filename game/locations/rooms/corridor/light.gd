extends Node2D


@onready var e_label = $ELabel
@onready var light_sprite = $LightSprite


const LIGHT_ON = preload("res://assets/light_on.png")
const LIGHT_OFF = preload("res://assets/light_off.png")


var somebody_close := false

func check_light(number):
	if number == 0:
		turn_off_light()
	else:
		turn_on_light()

func turn_on_light():
	light_sprite.texture = LIGHT_ON
	get_parent().modulate = Color("ffffff")

func turn_off_light():
	light_sprite.texture = LIGHT_OFF
	get_parent().modulate = Color("404040")

func _on_area_2d_body_entered(body):
	e_label.visible = true
	somebody_close = true

func _on_area_2d_body_exited(body):
	e_label.visible = false
	somebody_close = false

