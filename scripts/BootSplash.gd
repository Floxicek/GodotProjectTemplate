extends Control

@export var skipable: bool = true
@export var start_screen: PackedScene
@export var fade_duration = .2
@export var stay_duration = 1

func _input(event):
	if skipable and event.is_action_pressed("exit"):
		_change_scene()


func _change_scene():
	await get_tree().create_timer(.1).timeout
	if start_screen:
		get_tree().change_scene_to_packed(start_screen)
	else:
		printerr("Start screen scene is not setup in BootSplash")

func _fade_out():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property($TextureRect, "modulate:a", 0.0, fade_duration)\
	.set_delay(stay_duration)\
	.finished.connect(_change_scene)

func _ready():
	$TextureRect.modulate.a = 0.0
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property($TextureRect, "modulate:a", 1.0, fade_duration)\
	.from(0.0)\
	.finished.connect(_fade_out)
