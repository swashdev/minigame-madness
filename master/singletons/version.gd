extends Node
# A singleton node used to store the version number for the project.


# `MAJOR`, `MINOR`, and `PATCH` are as specified in the Semantic Versioning
# standard 2.0.0.  Note, however, that Minigame Madness's version numbering
# system is not compliant with the Semantic Versioning standard.
const MAJOR: int = 0
const MINOR: int = 13
const PATCH: int = 5
const BUILD: String = "stable"


func _to_string() -> String:
	var string: String = "%d.%d" % [MAJOR, MINOR]

	if PATCH > 0:
		string = string + ".%d" % PATCH

	if BUILD != "" and BUILD != "stable":
		string += "-" + BUILD

	return string
