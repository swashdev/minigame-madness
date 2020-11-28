extends Control
# A script for the main menu for Minigame Madness.


# Sets the version number for the label.
func set_version_number( year: int, week: int, day: int, hotfix: int = 0 ):
	var version = "%d.%d.%d" % [year, week, day]
	var hotfix_label
	if hotfix > 0:
		hotfix_label = "-hotfix%d" % hotfix
	else:
		hotfix_label = ""
	var full_version_string = "Version %s%s" % [version, hotfix_label]
	$VersionNumberLabel.text = full_version_string
