extends Line2D
class_name Ray

@onready var endCircle = $CircleCheck;
@onready var collBox = $StaticBody2D/CollisionPolygon2D;

var angle = 0;
var travelling: bool = true;

const speed = 6;


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var clr = Color.WHITE;
	clr.a = 0.5;
	default_color = clr;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if travelling:
		points[1] += Vector2.from_angle(angle) * speed;
	
	if !travelling:
		default_color = Color.WHITE;
		var normal = (points[1] - points[0]).normalized().rotated(PI / 2 if (abs(angle) < PI / 2) else -PI / 2) * 32;
		
		collBox.polygon = PackedVector2Array([
			points[0],
			points[0] + normal,
			points[1] + normal,
			points[1]
		]);
	
	endCircle.position = points[1];


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is TileMapLayer or body.get_parent() is Ray or body.get_parent() is Door:
		travelling = false;
