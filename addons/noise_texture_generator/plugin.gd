tool
extends EditorPlugin

var noise_texture_generator: PackedScene = preload("res://addons/noise_texture_generator/NoiseTextureGenerator.tscn")
var control: Control


func _enter_tree():
	control = noise_texture_generator.instance()
	add_control_to_bottom_panel(control, "NoiseTextureGenerator")


func _exit_tree():
	remove_control_from_bottom_panel(control)
