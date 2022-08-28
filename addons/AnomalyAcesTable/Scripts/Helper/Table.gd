extends Control
class_name Table, "res://addons/AnomalyAcesTable/Scripts/Helper/NoIcon.svg"

var _row = load("res://addons/AnomalyAcesTable/Scenes/Row.tscn")
var _table = load("res://addons/AnomalyAcesTable/Scenes/Table.tscn")

#Column Headers
var _columnHeaderContainer: HBoxContainer
var _columnHeaderPanel: PanelContainer
var _columnHeaderCellPanel: PanelContainer

#Rows
var _rowContainer : VBoxContainer
var _rowPanel: PanelContainer
var _rowCellPanel: PanelContainer

var plugin: TablePlugin
var tableConfig : TableConfig

var sn = 0
var data = [
	{
		"id": 100,
		"name": "blah",
		"class": "something",
		"role": "20"
	}
]

func _init(parent: TablePlugin, tblCfg: TableConfig):
	print("init with config called")
	
	tableConfig = tblCfg
	plugin = parent
	
	plugin.add_child(_table.instance())
	
	#Column Config
	
	## Theme Header Background 
	_columnHeaderPanel = plugin.get_node("VBoxContainer/ColumnHeaderPC")
	_columnHeaderPanel.set_theme(plugin.table_header_theme)
	
	## Theme Header Cell 
	_columnHeaderCellPanel = plugin.get_node("VBoxContainer/ColumnHeaderPC/MarginContainer/PanelContainer")
	_columnHeaderCellPanel.set_theme(plugin.table_header_cell_theme)
	
	##Resize the Container
	_columnHeaderContainer = plugin.get_node("VBoxContainer/ColumnHeaderPC/MarginContainer/PanelContainer/HBoxContainer")
	_columnHeaderContainer.size_flags_horizontal = SIZE_EXPAND_FILL
	_columnHeaderContainer.add_constant_override("separation", parent.table_cell_separation)
	
	#Row Config
	
	## Theme Row Background 
	_rowPanel = plugin.get_node("VBoxContainer/RowPC")
	_rowPanel.set_theme(plugin.table_row_theme)
	
	##Resize the Container
	_rowContainer = plugin.get_node("VBoxContainer/RowPC/MarginContainer/ScrollContainer/VBoxContainer")
	_rowContainer.size_flags_horizontal = SIZE_EXPAND_FILL
	_createColumnHeaders()
	

func _createColumnHeaders():
		
	
	#add columns to 
	for col_key in tableConfig.columnDefs:
		var colDict = tableConfig.columnDefs[col_key]
		var colDef: TableColumnDef = TableColumnDef.new(colDict)
	
		var label = Label.new()
		label.text = colDef.columnName
		label.name = colDef.columnId
		label.size_flags_horizontal = SIZE_EXPAND_FILL
		label.valign = Label.VALIGN_CENTER
		label.align = colDef.columnAlign
		_columnHeaderContainer.add_child(label)
	
#	var blankLabel = Label.new()
#	blankLabel.name = "Blank"
#	blankLabel.size_flags_horizontal = SIZE_EXPAND_FILL
#	_tableColumnHeaderContainer.add_child(blankLabel)


func set_data(dataArr:Array):
	for dataIdx in dataArr.size():
		var rowScene: PanelContainer = _row.instance()
		rowScene.name = "Row"+str(dataIdx)
		rowScene.set_theme(plugin.table_row_cell_theme)
		_rowContainer.add_child(rowScene)
		
		TableRow.new(plugin, tableConfig, dataArr[dataIdx], rowScene)
