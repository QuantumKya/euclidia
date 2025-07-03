extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventManager.ray_update.connect(_on_ray_update);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_ray_update(used: int, max: int) -> void:
	$RayCount.set("text", str(max - used) + "/" + str(max));
	
