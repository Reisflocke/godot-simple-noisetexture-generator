tool
extends TextureRect
# merges all 3 textures to 1 image

var channel_r: Image setget set_channel_r
var channel_g: Image setget set_channel_g
var channel_b: Image setget set_channel_b

var texture_r := ImageTexture.new()
var texture_g := ImageTexture.new()
var texture_b := ImageTexture.new()

onready var render_material: Material = $Viewport/ColorRect.material


func _ready():
	render_material.set_shader_param("channel_r", texture_r)
	render_material.set_shader_param("channel_g", texture_g)
	render_material.set_shader_param("channel_b", texture_b)
	
	self.texture = $Viewport.get_texture()


func set_channel_r(value: Image) -> void:
	channel_r = value
	texture_r.create_from_image(channel_r)


func set_channel_g(value: Image) -> void:
	channel_g = value
	texture_g.create_from_image(channel_g)


func set_channel_b(value: Image) -> void:
	channel_b = value
	texture_b.create_from_image(channel_b)



func _on_Size_text_entered(new_text):
	$Viewport.size = Vector2(int(new_text), int(new_text))
