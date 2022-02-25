# Holds all the configuration data for correctly exporting the documentation.
tool
class_name eh_DocsSettings
extends Resource

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

export(Array, String, DIR) var directories: Array = [] setget _set_directories
export(Array, String) var filters: Array = []
export var is_recursive: bool = true
export(String, DIR, GLOBAL) var save_path: String = ""

#--- private variables - order: export > normal var > onready -------------------------------------

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready() -> void:
	pass

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _set_directories(value: Array) -> void:
	if value.empty():
		value = [""]
	directories = value

### -----------------------------------------------------------------------------------------------
