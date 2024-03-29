extends WindowDialog
# A script for the popup window which explains the controls.


# The current slide being viewed.
var _slide: int = 0


func _ready():
	$HBoxContainer/HScrollBar.max_value = $Panel.get_child_count() - 1


# These two functions will move the panel to the next or the previous slide,
# respectively.
func next_slide():
	if _slide < $Panel.get_child_count() - 1:
		_slide += 1
	_refresh_slides()


func prev_slide():
	if _slide > 0:
		_slide -= 1
	_refresh_slides()


# The scrollbar has been dragged, change the slide appropriately.
func _on_HScrollBar_changed( value ):
	_slide = int( value )
	_refresh_slides()


# This function will reveal the current slide and hide the rest.
func _refresh_slides():
	$HBoxContainer/HScrollBar.value = _slide
	var slide: int = 0
	var slides = $Panel.get_children()
	while slide < slides.size():
		slides[slide].visible = slide == _slide
		slide += 1
	if _slide == 3:
		$Panel/Slide3/VBoxContainer/SpaceFiller2/RightKey.play()
	else:
		$Panel/Slide3/VBoxContainer/SpaceFiller2/RightKey.stop()


# The dialog box is being hidden; reset to the first slide.
func _on_ControlsDialog_popup_hide():
	_slide = 0
	_refresh_slides()
