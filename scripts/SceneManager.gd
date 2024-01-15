extends CanvasLayer

@onready var overlay = %Overlay

func change_scene(file_path: String):
	overlay.visible = true
	var tween = create_tween()
	await tween.tween_property(overlay, "color", Color("000f"), .3).finished
	
	get_tree().change_scene_to_file(file_path)
	
	tween = create_tween()
	await tween.tween_property(overlay, "color", Color("0000"), .3).finished
	overlay.visible = false
