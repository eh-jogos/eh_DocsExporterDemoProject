# Editor Field for checkbox, associated with a respective [BoolVariable], used by the Docs
# Exporter tab in the Project Settings.
# @category: UI Elements
tool
class_name BoolVariableCheckbox
extends CheckBox

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

var _property: String = ""
var _possible_properties: PoolStringArray = PoolStringArray()

onready var _settings: eh_DocsSettings = load(eh_DocsExporterPlugin.PATH_SETTINGS_RESOURCE)

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready():
	pressed = _settings.get(_property)
	_toggle_text()


func _toggled(button_pressed):
	_settings.set(_property, button_pressed)
	_toggle_text()

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _toggle_text():
	if pressed:
		text = "On"
	else:
		text = "Off"

### -----------------------------------------------------------------------------------------------


###################################################################################################
# Editor Methods ##################################################################################
###################################################################################################

### Custom Inspector builçt in functions ----------------------------------------------------------

func _get_property_list() -> Array:
	var properties: = []
	
	_reload_settings_resource()
	_add_bool_property_drop_down(properties)
	
	return properties


func _get(property: String):
	var value
	
	match property:
		"property":
			if _property.empty():
				value = _possible_properties[0]
			else:
				value = _property
	
	return value


func _set(property: String, value) -> bool:
	var has_handled: = false
	
	match property:
		"property":
			_property = value
			has_handled = true
	
	return has_handled

### -----------------------------------------------------------------------------------------------


### Helpers ---------------------------------------------------------------------------------------

func _reload_settings_resource() -> void:
	if not _settings:
		_settings = load(eh_DocsExporterPlugin.PATH_SETTINGS_RESOURCE)


func _add_bool_property_drop_down(properties: Array) -> void:
	_possible_properties = _get_possible_bool_properties()
	var hint_string: String = _possible_properties.join(",")
	
	var dict: = {
		name = "property",
		type = TYPE_STRING,
		hint = PROPERTY_HINT_ENUM,
		hint_string = hint_string,
		usage = PROPERTY_USAGE_DEFAULT
	}
	properties.append(dict)


func _get_possible_bool_properties() -> PoolStringArray:
	var value: = PoolStringArray()
	
	var settings_properties: = _settings.get_property_list()
	for property_dict in settings_properties:
		if property_dict.type == TYPE_BOOL and property_dict.name != "resource_local_to_scene":
			value.append(property_dict.name)
	return value

### -----------------------------------------------------------------------------------------------
