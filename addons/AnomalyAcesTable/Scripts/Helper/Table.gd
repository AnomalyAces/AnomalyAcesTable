extends Control
class_name Table, "res://addons/AnomalyAcesTable/Scripts/Helper/NoIcon.svg"

var _row = preload("res://addons/AnomalyAcesTable/Scenes/Row.tscn")
var _table = preload("res://addons/AnomalyAcesTable/Scenes/Table.tscn")
var _sorter = load("res://addons/AnomalyAcesTable/Scripts/Helper/TableSorter.gd").new()


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

func _init(parent: TablePlugin = null, tblCfg: TableConfig = null):
	
	if(parent == null || tblCfg == null):
		return
	
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
		
		var node_header: Control
		
		if colDef.columnSort:
			node_header = Button.new()
			(node_header as Button).connect("pressed", self, "_on_column_header_pressed_ascending", [node_header, col_key])
		else:
			node_header = Label.new()
			node_header.valign = Label.VALIGN_CENTER
		
		node_header.text = colDef.columnName
		node_header.name = colDef.columnId
		node_header.size_flags_horizontal = SIZE_EXPAND_FILL
		node_header.align = colDef.columnAlign
		_columnHeaderContainer.add_child(node_header)
	


func set_data(dataArr:Array):
	for dataIdx in dataArr.size():
		var rowScene = _row.instance()
		rowScene.name = "Row"+str(dataIdx)
		rowScene.set_theme(plugin.table_row_cell_theme)
		_rowContainer.add_child(rowScene)
		
		TableRow.new(plugin, tableConfig, dataArr[dataIdx], rowScene)


func get_rows():
	return _rowContainer.get_children()
	

func _on_column_header_pressed_ascending(node_header, col_key):
	_sorter.sort_row_by_column(self, col_key, TableConstants.ColumnSort.SORT_ASCENDING)

	node_header.disconnect("pressed", self, "_on_column_header_pressed_ascending")
	node_header.connect("pressed", self, "_on_column_header_pressed_descending", [node_header, col_key])

func _on_column_header_pressed_descending(node_header, col_key):
	_sorter.sort_row_by_column(self, col_key, TableConstants.ColumnSort.SORT_DESCENDING)
	
	node_header.disconnect("pressed", self, "_on_column_header_pressed_descending")
	node_header.connect("pressed", self, "_on_column_header_pressed_ascending", [node_header, col_key])
