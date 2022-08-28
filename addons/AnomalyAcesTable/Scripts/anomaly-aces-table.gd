tool
extends EditorPlugin

func _enter_tree():
	# Initialization of the plugin goes here.
	# Add the new type with a name, a parent type, a script and an icon.
	add_custom_type("Table", "Control",preload("Helper/TablePlugin.gd"), preload("../AnomalyAcesTable.svg"))
	
	#Add singletons
#	add_autoload_singleton("TableColumnDef","res://addons/AnomalyAcesTable/Scripts/Helper/TableColumnDef.gd" )
#	add_autoload_singleton("TableConfig", "res://addons/AnomalyAcesTable/Scripts/Helper/TableConfig.gd")
#	add_autoload_singleton("TablePlugin", "res://addons/AnomalyAcesTable/Scripts/Helper/TablePlugin.gd")
#	add_autoload_singleton("TableRow", "res://addons/AnomalyAcesTable/Scripts/Helper/TableRow.gd")
#	add_autoload_singleton("Table", "res://addons/AnomalyAcesTable/Scripts/Helper/Table.gd")
	
	add_autoload_singleton("TableManager", "res://addons/AnomalyAcesTable/Scripts/TableManager.gd")
	add_autoload_singleton("TableConstants", "res://addons/AnomalyAcesTable/Scripts/Helper/TableConstants.gd")
	


func _exit_tree():
	# Clean-up of the plugin goes here.
	# Always remember to remove it from the engine when deactivated.
	remove_custom_type("Table")
	
	#Remove Singletons
#	remove_autoload_singleton("TableColumnDef")
#	remove_autoload_singleton("TableConfig")
#	remove_autoload_singleton("TablePlugin")
#	remove_autoload_singleton("TableRow")
#	remove_autoload_singleton("Table")
	
	remove_autoload_singleton("TableManager")
	remove_autoload_singleton("TableConstants")
