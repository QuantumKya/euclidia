extends Control

var paused: bool = false;

@export var main: Node;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pauseMenu();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range(3):
		if main.card_collection[i]:
			get_child(i).texture = main.card_collection[i];

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		paused = !paused;
		pauseMenu();

func pauseMenu():
	if paused:
		show();
		Engine.time_scale = 0;
	else:
		hide();
		Engine.time_scale = 1;


func _on_resume() -> void:
	paused = false;
	pauseMenu();
