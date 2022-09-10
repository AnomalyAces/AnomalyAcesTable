tool
extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var table: Table
var tablePlugin: TablePlugin

# Called when the node enters the scene tree for the first time.
func _ready():
	tablePlugin = $Table
	var colDefs = {
		"foo":{
			"columnId": "foo",
			"columnName": "Foo",
			"columnSort": true,
			"columnType": TableConstants.ColumnType.LABEL,
						"columnAlign": TableConstants.Align.CENTER
		},
		"bar":{
			"columnId": "bar",
			"columnName": "Bar",
			"columnType": TableConstants.ColumnType.BUTTON,
			"columnImage": "res://icon.png",
			"columnFunc": funcref(self, "button_pressed"),
						"columnAlign": TableConstants.Align.CENTER
			
		},
		"foobar":{
			"columnId": "foobar",
			"columnName": "FooBar",
			"columnType": TableConstants.ColumnType.TEXTURE_RECT,
						"columnAlign": TableConstants.Align.CENTER
			
		},
	}	
	var data = {
			"foo":"10",
			"bar":"Press Me",
			"foobar": "res://icon.png"
		}
	
	var data2 = {
			"foo":"15",
			"bar":"Press Me",
			"foobar": "res://icon.png"
		}
		
	var data3 = {
			"foo":"11",
			"bar":"Press Me",
			"foobar": "res://icon.png"
		}
	
	var textRect = TextureRect.new()
	textRect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	textRect.size_flags_horizontal = SIZE_EXPAND_FILL
	textRect.set_texture(load("res://icon.png"))
	var colNodeDefs = {
		"textureRect": textRect
	}
	
	var tblConfig : TableConfig = TableManager.createTableConfig(colDefs, data)
	table = TableManager.createTable(tablePlugin, tblConfig)
	TableManager.setTableData(table, [data, data2, data3])
	
	print(tablePlugin.to_string())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func button_pressed(var1: Dictionary):
	print("Arg1 from Button: %s" % [var1])
