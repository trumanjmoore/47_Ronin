extends Node

# A simple function to change the current scene to the specified path.
func change_scene(scene_path: String):
	if ResourceLoader.exists(scene_path):
		get_tree().change_scene_to_file(scene_path)
