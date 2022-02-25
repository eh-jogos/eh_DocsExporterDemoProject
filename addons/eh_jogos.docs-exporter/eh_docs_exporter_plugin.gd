tool
extends EditorPlugin

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

const PATH_TAB = \
		"res://addons/eh_jogos.docs-exporter/editor_uis/DocsExporterProjectSettingsTab.tscn"
const PATH_SETTINGS_RESOURCE = "res://addons/eh_jogos.docs-exporter/docs_settings.tres"

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

var _settings: eh_DocsSettings

var _docs_exporter_tab: Control
var _shared_variables_path = "res://addons/eh_jogos.docs-exporter/shared_variables/"

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func enable_plugin() -> void:
	_create_shared_db(_shared_variables_path + "dict_custom_class_db.tres")
	_create_shared_db(_shared_variables_path + "dict_custom_inheritance_db.tres")
	_create_shared_db(_shared_variables_path + "dict_category_db.tres")


func _enter_tree():
	_settings = load(PATH_SETTINGS_RESOURCE)
	_docs_exporter_tab = load(PATH_TAB).instance()
	add_control_to_container(
			EditorPlugin.CONTAINER_PROJECT_SETTING_TAB_RIGHT, 
			_docs_exporter_tab
	)
	_docs_exporter_tab.initialize_tab(_settings, get_editor_interface())


func _exit_tree():
	remove_control_from_container(
			EditorPlugin.CONTAINER_PROJECT_SETTING_TAB_RIGHT, 
			_docs_exporter_tab
	)
	_docs_exporter_tab.free()
	pass


func save_external_data() -> void:
	ResourceSaver.save(PATH_SETTINGS_RESOURCE, _settings)

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _create_shared_db(path: String) -> void:
	var dict_variable: DictionaryVariable = DictionaryVariable.new()
	if not ResourceLoader.exists(path):
		ResourceSaver.save(path, dict_variable)

### -----------------------------------------------------------------------------------------------
