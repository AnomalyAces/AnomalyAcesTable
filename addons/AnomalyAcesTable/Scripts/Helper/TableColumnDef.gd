extends Node
class_name TableColumnDef, "res://addons/AnomalyAcesTable/Scripts/Helper/NoIcon.svg"

const INVALID_TYPE: int = -1

var columnName: String
var columnId: String
var columnType: int
var columnAlign: int
var columnImage: String
var columnFunc: FuncRef


func _init(colDef: Dictionary):
	if(_validateColDef(colDef)):
		columnId = colDef.columnId
		columnName = colDef.columnName
		
		if(colDef.columnType > 0):
			columnType = colDef.columnType
		else:
			columnType = TableConstants.ColumnType.LABEL
		
		if(colDef.has("columnImage") && !colDef.columnImage.empty()):
			columnImage = colDef.columnImage
		if(colDef.has("columnFunc") && colDef.columnFunc != null):
			columnFunc = colDef.columnFunc
		if(colDef.has("columnAlign")):
			columnAlign = colDef.columnAlign
		else:
			columnAlign = 0
	else:
		columnType = INVALID_TYPE
		push_error("Column Def %s does not contain one or more of the following members: 'columnId', 'columnName', 'columnType' " % [colDef])

func _validateColDef(colDef: Dictionary) -> bool:
	var isValid: bool = true
	if(!colDef.has("columnId")):
		isValid = false;
	if(!colDef.has("columnName")):
		isValid = false;
	if(!colDef.has("columnType")):
		isValid = false;
	return isValid

func isValid() -> bool:
	var isValid: bool = true
	if(columnId.empty()):
		isValid = false
	if(columnName.empty()):
		isValid = false
	if(columnType < 0):
		isValid = false
	if(columnType == TableConstants.ColumnType.BUTTON && columnFunc == null):
		isValid = false
	return isValid
