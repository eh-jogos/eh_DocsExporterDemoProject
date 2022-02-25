# Base class for any kind of PathLineEdit field. Receives a [String], which will be 
# responsible not only for the persistence of the data as well as sharing it with any part
# of the project that needs it.
#
# In the addon there are 3 Scenes for different kind of paths that are used in the Docs Exporter
# tab, one for file paths in the file system, one for directories in the project, and another for
# directories in the file system.
# @category: UI Elements
tool
class_name FilePathLineEdit
extends HBoxContainer

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

signal update_value(index, value)
signal remove_value(index)

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

# Filters for the File Explorer window.
export var file_dialog_filter: = ""
# Option to turn on/off the remove field button.
export var is_removable: = false setget _set_is_removable

#--- private variables - order: export > normal var > onready -------------------------------------

var _index: int = -1

onready var _line_edit: LineEdit = $PathLineEdit
onready var _file_dialog: FileDialog = $FileExplorerButton/FileDialog
onready var _delete_button: Button = $DeleteButton

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready() -> void:
	if file_dialog_filter != "":
		_file_dialog.add_filter(file_dialog_filter)

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

# Sets the StringVariable this field will be attached to and populates the LineEdit with its value.
func set_field_value(value: String, index: int) -> void:
	_line_edit.set_text(value)
	_index = index
	
	if _index == 0:
		_set_is_removable(false)
	else:
		_set_is_removable(true)

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _set_is_removable(value: bool) -> void:
	is_removable = value
	_delete_button.visible = value


func _update_path_variable(path: String) -> void:
	emit_signal("update_value", _index, path)


func _on_LineEdit_text_changed(new_text: String) -> void:
	_update_path_variable(new_text)


func _on_LineEdit_text_entered(new_text: String) -> void:
	_update_path_variable(new_text)


func _on_FileDialog_dir_selected(dir: String) -> void:
	_update_path_variable(dir)


func _on_FileDialog_file_selected(path: String) -> void:
	_update_path_variable(path)


func _on_DeleteButton_pressed():
	emit_signal("remove_value", _index)

### -----------------------------------------------------------------------------------------------
