tool
extends Control

var table_header_theme: Theme
var table_header_cell_theme: Theme
var table_row_theme: Theme
var table_row_cell_theme: Theme
var table_cell_separation: int

func _print(args):
	print(args)

func _get_property_list():
	return [
		{
			"name": "Table Properties",
			"type": TYPE_NIL,
			"hint_string": "table_",
			"usage": PROPERTY_USAGE_CATEGORY | PROPERTY_USAGE_SCRIPT_VARIABLE
		},
		{
			"name": "table_header_theme",
			"type": TYPE_OBJECT,
			"hint": PROPERTY_HINT_RESOURCE_TYPE,
			"hint_string": "Theme"
		},
		{
			"name": "table_header_cell_theme",
			"type": TYPE_OBJECT,
			"hint": PROPERTY_HINT_RESOURCE_TYPE,
			"hint_string": "Theme"
		},
		{
			"name": "table_row_theme",
			"type": TYPE_OBJECT,
			"hint": PROPERTY_HINT_RESOURCE_TYPE,
			"hint_string": "Theme"
		},
		{
			"name": "table_row_cell_theme",
			"type": TYPE_OBJECT,
			"hint": PROPERTY_HINT_RESOURCE_TYPE,
			"hint_string": "Theme"
		},
		{
			"name": "table_cell_separation",
			"type": TYPE_INT,
			"hint":  PROPERTY_HINT_NONE
		},
	]

func _to_string():
	var headerTheme = null if table_header_theme == null else table_header_theme.resource_path
	
	return "table_header_theme: %s" % [headerTheme]
