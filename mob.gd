extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# variable que tenga una arreglo con los nombres de las animaciones
	var mob_type = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_type.pick_random() # obtener una animacion al azar
	$AnimatedSprite2D.play() # ejecutar la animacion


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free() # eliminar el nodo
