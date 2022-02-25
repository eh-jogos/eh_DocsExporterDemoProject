# Write your doc string for this file here
tool
extends Control

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

var _settings: eh_DocsSettings
var _editor_interface: EditorInterface

onready var sections = $Panel/ScrollContainer/ContentList.get_children()

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready() -> void:
	pass

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

func initialize_tab(settings: eh_DocsSettings, p_editor_interface: EditorInterface) -> void:
	_editor_interface = p_editor_interface
	_settings = settings
	connect("visibility_changed", self, "_on_visibility_changed")

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _update_sections() -> void:
	for section in sections:
		if section.has_method("load_settings"):
			section.load_settings(_settings)


func _on_visibility_changed() -> void:
	if visible:
		_update_sections()

### -----------------------------------------------------------------------------------------------
