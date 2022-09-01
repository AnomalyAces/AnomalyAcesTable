extends PanelContainer
class_name TableRow, "res://addons/AnomalyAcesTable/Scripts/Helper/NoIcon.svg"

signal pressed

var _cellContainer: HBoxContainer

var colDefs: Array = []
var defaultPlugin = TablePlugin.new()
var defaultConfig = TableConfig.new()


func _init(plugin:TablePlugin=null, tblCfg: TableConfig=null, dt: Dictionary = {}, rowScene = null):
	
	if(plugin == null || tblCfg == null || rowScene == null):
		return
	
	_cellContainer = rowScene.get_node("MarginContainer/Row")
	_cellContainer.add_constant_override("separation", plugin.table_cell_separation)
	
	for key in tblCfg.columnDefs:
		var colDefDict: Dictionary = tblCfg.columnDefs[key]
		var colDef: TableColumnDef = TableColumnDef.new(colDefDict)
		if(colDef.isValid()):
			colDefs.append(colDef)
	
	if(colDefs.size() == tblCfg.columnDefs.size()):
		for col in colDefs:
			var colDef: TableColumnDef = col as TableColumnDef
			
			match colDef.columnType:
				TableConstants.ColumnType.LABEL:
					var label: Label = _getLabelFromConfig(tblCfg, dt, colDef)
					_cellContainer.add_child(label)
				TableConstants.ColumnType.BUTTON:
					var button: BaseButton = _getButtonFromConfig(tblCfg, dt, colDef)
					_cellContainer.add_child(button)
				TableConstants.ColumnType.TEXTURE_RECT:
					var image = _getTextureRectFromConfig(tblCfg, dt, colDef)
					_cellContainer.add_child(image)
				_:
					push_error("Column Def %s column type %s is unknown" % [colDef, colDef.columnType])
	else:
		push_error("Number of valid Column Defs (%s) does not match the number of given Column Defs (%s)" % [colDefs.size(),tblCfg.columnDefs.size() ])

func _validateRowData(rowData: Dictionary) -> bool:
	var isValid: bool = true
	if(!rowData.has("columnId")):
		isValid = false;
	if(!rowData.has("columnName")):
		isValid = false;
	if(!rowData.has("columnType")):
		isValid = false;
	return isValid

func _getLabelFromConfig(tblCfg: TableConfig, dt: Dictionary, colDef: TableColumnDef) -> Label:
	var label: Label
	if(tblCfg.columnNodeDefs.label != null):
		label = tblCfg.columnNodeDefs.label
		label.name = colDef.columnId
		label.text = dt[colDef.columnId]
	else:
		label = Label.new()
		label.text = dt[colDef.columnId]
		label.name = colDef.columnId
		label.size_flags_horizontal = SIZE_EXPAND_FILL
		label.align = colDef.columnAlign
	
	return label

func _getButtonFromConfig(tblCfg: TableConfig, dt: Dictionary, colDef: TableColumnDef) -> BaseButton: 
	var button: Button
	
	if(tblCfg.columnNodeDefs.button != null):
		button = tblCfg.columnNodeDefs.button as Button
		button.name = colDef.columnId
		button.text = dt[colDef.columnId]
	else:
		button = Button.new()
		button.text = dt[colDef.columnId]
		button.name = colDef.columnId
		button.size_flags_horizontal = SIZE_EXPAND_FILL
		button.align = colDef.columnAlign
		button.connect("pressed", self, "_on_Button_pressed", [colDef.columnFunc, dt])
		if(!colDef.columnImage.empty()):
			button.set_button_icon(load(colDef.columnImage))
		
	return button
		
	

func _getTextureRectFromConfig(tblCfg: TableConfig, dt: Dictionary, colDef: TableColumnDef) -> TextureRect:
	var textureRect: TextureRect
	if(tblCfg.columnNodeDefs.textureRect != null):
		textureRect = tblCfg.columnNodeDefs.textureRect
		textureRect.name = colDef.columnId
	else:
		textureRect = TextureRect.new()
		textureRect.name = colDef.columnId
		textureRect.size_flags_horizontal = SIZE_EXPAND_FILL
		textureRect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		textureRect.set_texture(load(dt[colDef.columnId]))
	return textureRect
	
func _on_Button_pressed(funcRef: FuncRef, data: Dictionary):
	funcRef.call_func(data)
