tool
extends HBoxContainer
# generate your own rgb noise

enum {CHANNEL_R, CHANNEL_G, CHANNEL_B}

var noise_size: Vector2 = Vector2(512, 512) setget set_noise_size
var noise_texture := NoiseTexture.new()

onready var edit_viewport_container := $VBoxContainer/ScrollContainer/ViewportContainer
onready var edit_viewport: Viewport = $VBoxContainer/ScrollContainer/ViewportContainer/Viewport
onready var scroll_container := $VBoxContainer/ScrollContainer
onready var channel_composer: = $VBoxContainer2/ChannelComposer

onready var file_path: LineEdit = $VBoxContainer2/HBoxContainer2/FilePath


func _ready():
	noise_texture.noise = OpenSimplexNoise.new()
	$VBoxContainer/ScrollContainer/ViewportContainer/Viewport/ColorRect.material.set_shader_param("noise_texture", noise_texture)
	set_noise_size(noise_texture.get_size())


# NOISE SIZE

func set_noise_size(value: Vector2) -> void:
	noise_size = value
	
	edit_viewport_container.rect_min_size = noise_size
	noise_texture.width = noise_size.x
	noise_texture.height = noise_size.y
	scroll_container.rect_min_size = noise_size.clamped(725)


func _on_Size_text_entered(new_text):
	self.noise_size = Vector2(int(new_text), int(new_text))


# APPLY NOISE TO COLOR CHANNELS

func get_noise_image() -> Image:
	var img := edit_viewport.get_texture().get_data()
	img.flip_y()
	return img


func apply_texture_to(channel: int) -> void:
	match channel:
		CHANNEL_R:
			channel_composer.channel_r = get_noise_image()
		CHANNEL_G:
			channel_composer.channel_g = get_noise_image()
		CHANNEL_B:
			channel_composer.channel_b = get_noise_image()


# SAVE TO FILE

func _on_Save_pressed():
	get_noise_image().save_png(file_path.text)



func _on_Seed_value_changed(value):
	noise_texture.noise.seed = value


func _on_Octaves_value_changed(value):
	noise_texture.noise.octaves = value


func _on_Period_value_changed(value):
	noise_texture.noise.period = value


func _on_Persistence_value_changed(value):
	noise_texture.noise.persistence = 100/value


func _on_Lacunarity_value_changed(value):
	noise_texture.noise.lacunarity = value/10


func _on_Seamsless_toggled(button_pressed):
	noise_texture.seamless = button_pressed
