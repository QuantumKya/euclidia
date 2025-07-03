extends Camera2D

@onready var player: CharacterBody2D = $"../Player";

var playerOffset: Vector2 = Vector2.ZERO;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var tween = get_tree().create_tween();
	tween.tween_property(self, "position", player.position + playerOffset, 1.0);


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is CameraGuide:
		playerOffset = area.offsetVector;
		var tween = get_tree().create_tween();
		tween.tween_property(self, "scale", Vector2.ONE / area.zoom, 1.6);
		tween.parallel().tween_property(self, "zoom", Vector2.ONE * area.zoom, 1.6);
