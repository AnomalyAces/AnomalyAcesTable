extends Control

const Row = preload("res://addons/AnomalyAcesTable/Scripts/Helper/Row.gd")
const Config = preload("res://addons/AnomalyAcesTable/Scripts/Helper/TableConfig.gd")
const ColumnDef = preload("res://addons/AnomalyAcesTable/Scripts/Helper/TableColumnDef.gd")
const Plugin = preload("res://addons/AnomalyAcesTable/Scripts/Helper/TablePlugin.gd")

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

var plugin: Plugin
var tableConfig : Config

var sn = 0
var data = [
	{
		"id": 100,
		"name": "blah",
		"class": "something",
		"role": "20"
	}
]

func _init(parent: Plugin, tblCfg: Config):
	print("init with config called")
	
	tableConfig = tblCfg
	plugin = parent
	
	parent.add_child(_table.instance())
	
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
		var colDef: ColumnDef = ColumnDef.new(colDict)
	
		var label = Label.new()
		label.text = colDef.columnName
		label.name = colDef.columnId
		label.size_flags_horizontal = SIZE_EXPAND_FILL
		label.valign = Label.VALIGN_CENTER
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
		
		Row.new(tableConfig, dataArr[dataIdx], rowScene)
