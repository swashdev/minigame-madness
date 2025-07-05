extends Node
# A singleton node used to store the version number for the project.


const MAJOR: int = 0
const MINOR: int = 14
const MINOR_2nd: int = 2
const PATCH: int = 0
const BUILD: String = "alpha.1.pre"


# Returns the version number in its preferred pseudo-semantic versioning form.
# Patch number 0 is left out for historical reasons.
func get_version_string() -> String:
	var result: String = str(MAJOR) + "." + str(MINOR)

	if MINOR_2nd > 0:
		result += "_" + str(MINOR_2nd)
	if PATCH > 0:
		result += "." + str(PATCH)

	if BUILD != "" and BUILD != "stable":
		result += "-" + BUILD.replace("\\.", ".")

	return result


# Returns the version number as a string.  The output is verbose and intended
# to be human-readable and pleasant.
func get_nice_version() -> String:
	var result: String = str(MAJOR) + "." + str(MINOR)

	if MINOR_2nd > 0:
		result += "_" + str(MINOR_2nd)
	if PATCH > 0:
		result += "." % str(PATCH)

	if BUILD != "" and BUILD != "stable":
		var prerelease_data: Array = BUILD.split(".", false)
		var include_dot: bool = false
		for element in prerelease_data:
			if element == "stable":
				break
			elif element == "dev":
				result += " Dev Build"
			elif element == "rc":
				result += " Release Candidate"
			elif element == "pre":
				result += " Prerelease"
			else:
				# If the dot from the previous element was escaped, add a dot
				# rather than a space.
				result += "." if include_dot else " "
				# If the element ends with a backslash, the dot is escaped and
				# should be preserved.
				include_dot = element.ends_with('\\')
				if include_dot:
					# Strip the trailing backslash from the element.
					element = element.trim_suffix("\\")
				result += element.capitalize()

	return result
