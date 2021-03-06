tool
extends Button

export var texture_param: String
export var channel_composer: NodePath


func _ready():
	$TextureRect.texture = get_node(channel_composer).get(texture_param)
