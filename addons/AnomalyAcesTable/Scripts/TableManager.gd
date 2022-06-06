extends Node

const Table = preload("res://addons/AnomalyAcesTable/Scripts/Helper/Table.gd")
const Row = preload("res://addons/AnomalyAcesTable/Scripts/Helper/Row.gd")
const Config = preload("res://addons/AnomalyAcesTable/Scripts/Helper/TableConfig.gd")
const Plugin = preload("res://addons/AnomalyAcesTable/Scripts/Helper/TablePlugin.gd")

func createTableConfig(colDefs: Dictionary, colNodeDefs: Dictionary = {}):
	return Config.new(colDefs, colNodeDefs)

func createTable(parent: Plugin, tblCfg: Config):
	return Table.new(parent, tblCfg)

func setTableData(table: Table, data: Array):
	table.set_data(data)
