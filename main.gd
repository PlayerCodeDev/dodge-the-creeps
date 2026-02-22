extends Node
@export var mob_scene: PackedScene
var score


func games_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_games_over()


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")


func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	
	# elegimos una locaclizacion al azar en Path2D (MobPath)
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	mob.position = mob_spawn_location.position
	
	# tomamos la direccion perpendicular a la direccion del Path2D
	var direction = mob_spawn_location.rotation + PI / 2
	
	# agregamos una direccion aleatoria
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# seteamos la velocidad del enemigo
	var velocity = Vector2(randf_range(105.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# agregamos al enemigo a la escena
	add_child(mob)


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
