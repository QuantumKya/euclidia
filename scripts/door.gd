extends Sprite2D
class_name Door;

@export var button: Node2D;

var duration = 1.0;
var org_scale;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	org_scale = scale;
	
	button.pressed.connect(_on_button_press);
	button.unpressed.connect(_on_button_release);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_press() -> void:
	var tween = get_tree().create_tween();
	var new_scale = Vector2(org_scale.x, 0);
	tween.tween_property(self, "scale", new_scale, duration);

func _on_button_release() -> void:
	var tween = get_tree().create_tween();
	tween.tween_property(self, "scale", org_scale, duration);
