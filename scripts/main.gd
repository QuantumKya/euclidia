extends Node
class_name Main

var card_collection: Array[Texture2D] = [null, null, null];

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D/HUD.show();
	EventManager.card_collected.connect(_on_card_collected);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_card_collected(id: int) -> void:
	card_collection[id] = load("res://sprite/card" + str(id) + ".png");
