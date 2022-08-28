extends Node


func createTableConfig(colDefs: Dictionary, colNodeDefs: Dictionary = {}):
	return TableConfig.new(colDefs, colNodeDefs)

func createTable(parent: TablePlugin, tblCfg: TableConfig):
	return Table.new(parent, tblCfg)

func setTableData(table: Table, data: Array):
	table.set_data(data)
