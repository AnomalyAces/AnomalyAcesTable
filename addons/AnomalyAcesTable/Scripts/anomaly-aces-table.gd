tool
extends EditorPlugin

func _enter_tree():
	# Initialization of the plugin goes here.
	# Add the new type with a name, a parent type, a script and an icon.
	add_custom_type("Table", "Control",preload("Helper/TablePlugin.gd"), preload("../AnomalyAcesTable.svg"))
	
	#Add singletons
	add_autoload_singleton("TableManager", "res://addons/AnomalyAcesTable/Scripts/TableManager.gd")
	add_autoload_singleton("TableConstants", "res://addons/AnomalyAcesTable/Scripts/Helper/TableConstants.gd")
	


func _exit_tree():
	# Clean-up of the plugin goes here.
	# Always remember to remove it from the engine when deactivated.
	remove_custom_type("Table")
	
	#Remove Singletons
	remove_autoload_singleton("TableManager")
	remove_autoload_singleton("TableConstants")
