extends Node
# A singleton node used to store the version number for the project.


# `MAJOR`, `MINOR`, and `PATCH` are as specified in the Semantic Versioning
# standard 2.0.0.  Note, however, that Minigame Madness's version numbering
# system is not compliant with the Semantic Versioning standard.
const MAJOR: int = 0
const MINOR: int = 14
const MINOR_2nd: int = 1
const PATCH: int = 0
const BUILD: String = "alpha.1"


func _to_string() -> String:
	var string: String = "%d.%d" % [MAJOR, MINOR]

	if MINOR_2nd > 0:
		string = string + "_%d" % MINOR_2nd

	if PATCH > 0:
		string = string + ".%d" % PATCH

	if BUILD != "" and BUILD != "stable":
		string += "-" + BUILD

	return string
