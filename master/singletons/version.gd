extends Node
# A singleton node used to store the version number for the project.


# `MAJOR`, `MINOR`, and `PATCH` are as specified in the Semantic Versioning
# standard 2.0.0.  Note, however, that Minigame Madness's version numbering
# system is not compliant with the Semantic Versioning standard.
const MAJOR: int = 0
const MINOR: int = 13
const PATCH: int = 0

# `AS_HEX` is the version number expressed as a single hexadecimal value where
# each of `MAJOR`, `MINOR`, and `PATCH` are given two hexadecimal digits.  This
# can be used to quickly compare version numbers in source code, but has no
# practical user-facing function.
const AS_HEX: int = 0x00_13_00


func _to_string() -> String:
	var string: String = "%d.%d" % [MAJOR, MINOR]

	if PATCH > 0:
		string = string + ".%d" % PATCH

	return string + "-custom_build"
