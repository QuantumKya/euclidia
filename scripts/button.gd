extends Sprite2D

signal pressed;
signal unpressed;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Ray:
		region_rect.position.x = 64;
		emit_signal("pressed");


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.get_parent() is Ray:
		region_rect.position.x = 0;
		emit_signal("unpressed");


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		region_rect.position.x = 64;
		emit_signal("pressed");


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		region_rect.position.x = 0;
		emit_signal("unpressed");
