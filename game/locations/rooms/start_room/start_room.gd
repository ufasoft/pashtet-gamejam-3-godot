extends Node2D

@onready var character = $Character




func _on_right_door_body_entered(body):
	Sfx.play_door()
	get_tree().change_scene_to_file("res://game/locations/rooms/corridor/endless_corridor.tscn")
