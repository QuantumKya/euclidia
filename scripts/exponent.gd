extends RichTextEffect
class_name RichTextSuperscript # Optional: Add a class name

var bbcode = "sup" # Your custom BBCode tag

func _process_custom_fx(char_fx: CharFXTransform):
	# Adjust the character's vertical offset to raise it
	char_fx.offset = Vector2(0, char_fx.env.offset_y if char_fx.env.has("offset_y") else -5) 
	# You might also want to scale down the text, though this requires additional implementation.
	# char_fx.scale = Vector2(0.8, 0.8) # Example scaling down

	return true
