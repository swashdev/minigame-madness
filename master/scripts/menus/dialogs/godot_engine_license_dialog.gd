extends WindowDialog


signal pressed_godot_link


func _on_GodotLink_pressed():
	emit_signal( "pressed_godot_link" )
