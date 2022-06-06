extends Node

#Array of Column Defs to define what Columns Names and Column id of the data entered
var columnDefs: Dictionary

#Optional Defintions for nodes supported by the table. If provided these will be used instead of the defaults
#enum ColumnType {
#	LABEL,
#	BUTTON,
#	TEXTURE_RECT
#}
var columnNodeDefs: ColumnNodeDefs


func _init(colDefs: Dictionary, colNodeDefs: Dictionary = {}):
	columnDefs = colDefs
	columnNodeDefs = ColumnNodeDefs.new(colNodeDefs)

class ColumnNodeDefs:
	var label: Label
	var button: BaseButton
	var textureRect: TextureRect
	
	func _init(colNodeDefs: Dictionary):
		label = null if not colNodeDefs.has("label") else colNodeDefs["label"]
		button = null if not colNodeDefs.has("button") else colNodeDefs["button"]
		textureRect = null if not colNodeDefs.has("textureRect") else colNodeDefs["textureRect"]
