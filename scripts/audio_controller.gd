extends Node2D

@export var mute: bool = false;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func play_card_collect() -> void:
	if not mute:
		$CardCollect.play();
