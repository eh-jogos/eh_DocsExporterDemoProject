# Write your doc string for this file here
tool
extends LineEdit

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

const EXCLUDED_PROPERTIES = [
		"resource_path",
		"resource_name",
]

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

var _property: String = ""
var _possible_properties: PoolStringArray = PoolStringArray()

onready var _settings: eh_DocsSettings = load(eh_DocsExporterPlugin.PATH_SETTINGS_RESOURCE)

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready() -> void:
	text = _settings.get(_property)

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _on_LineEdit_text_changed(new_text: String) -> void:
	_settings.set(_property, new_text)


func _on_LineEdit_text_entered(new_text: String) -> void:
	_settings.set(_property, new_text)

### -----------------------------------------------------------------------------------------------

###################################################################################################
# Editor Methods ##################################################################################
###################################################################################################

### Custom Inspector builçt in functions ----------------------------------------------------------

func _get_property_list() -> Array:
	var properties: = []
	
	_reload_settings_resource()
	_add_string_property_drop_down(properties)
	
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


func _add_string_property_drop_down(properties: Array) -> void:
	_possible_properties = _get_possible_string_properties()
	var hint_string: String = _possible_properties.join(",")
	
	var dict: = {
		name = "property",
		type = TYPE_STRING,
		hint = PROPERTY_HINT_ENUM,
		hint_string = hint_string,
		usage = PROPERTY_USAGE_DEFAULT
	}
	properties.append(dict)


func _get_possible_string_properties() -> PoolStringArray:
	var value: = PoolStringArray()
	
	var settings_properties: = _settings.get_property_list()
	for property_dict in settings_properties:
		if property_dict.name in EXCLUDED_PROPERTIES:
			continue
		
		if property_dict.type == TYPE_STRING:
			value.append(property_dict.name)
	
	return value

### -----------------------------------------------------------------------------------------------
