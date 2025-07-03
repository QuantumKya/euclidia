extends Sprite2D

@export var id: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		EventManager.emit_signal("card_collected", id);
		AudioController.play_card_collect();
		
		self.queue_free();
