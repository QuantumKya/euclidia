extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		EventManager.emit_signal("ray_upgraded");
		
		self.queue_free();
