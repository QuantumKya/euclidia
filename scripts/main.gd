extends Node
class_name Main

@export var great_barrier: StaticBody2D;

var card_collection: Array[Texture2D] = [null, null, null, null, null, null, null];

const card_names = [
	"point",
	"line",
	"endpoints",
	"straight_line",
	"surface",
	"endlines",
	"plane"
];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D/HUD.show();
	EventManager.card_collected.connect(_on_card_collected);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_card_collected(id: int) -> void:
	card_collection[id] = load("res://sprite/cards/" + card_names[id] + ".png");
	
	if card_collection[6] == null:
		var open: bool = true;
		for i in range(6):
			open = open and (card_collection[i] != null);
			print(open);
		
		if open:
			great_barrier.queue_free();
