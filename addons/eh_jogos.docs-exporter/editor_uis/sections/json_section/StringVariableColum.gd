# Script for columns that need to populate PoolStringArray fields.
tool
extends VBoxContainer

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

export var _editor_field_packed_scene: PackedScene = null

var _string_array: Array = []

onready var _field_container: VBoxContainer = $Fields

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready():
	pass

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

func initialize_editor_fields(p_settings: eh_DocsSettings, p_property: String) -> void:
	if not p_settings.is_valid_string_array_property(p_property):
		push_error("%s is not a valid propertty for String fields"%[p_property])
		return
	_string_array = p_settings.get(p_property)
	_populate_editor_fields()


### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

# Populates with some kind of editor field that accepts a StringVariable, and gives each one it's
# respective StringVariable. Also takes care of showing the delete button when needed and
# connecting it to its function.
func _populate_editor_fields() -> void:
	for row in _field_container.get_children():
		_field_container.remove_child(row)
		row.queue_free()
	
	var row_count: = 0
	for value in _string_array:
		var editor_field: FilePathLineEdit = _editor_field_packed_scene.instance()
		_field_container.add_child(editor_field, true)
		editor_field.set_field_value(value, row_count)
		
		editor_field.connect("update_value", self, "_on_editor_field_update_value")
		if editor_field.is_removable:
			editor_field.connect("remove_value", self, "_on_editor_field_remove_value")
		
		row_count += 1


func _on_AddMore_pressed() -> void:
	_string_array.append("")
	_populate_editor_fields()


func _on_editor_field_update_value(index: int, value: String) -> void:
	if index > _string_array.size():
		for new_index in range(_string_array.size(), index):
			_string_array.append("")
	
	_string_array[index] = value


func _on_editor_field_remove_value(index: int) -> void:
	_string_array.remove(index)
	_populate_editor_fields()

### -----------------------------------------------------------------------------------------------
