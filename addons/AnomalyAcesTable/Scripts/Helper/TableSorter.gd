class_name TableSorter

var inner_column_name : String

func sort_row_by_column(table, column_name: String, sorting_type):
	### Check ###
	if sorting_type == TableConstants.ColumnSort.NONE:
			push_warning("Sorting called but filter method is None")
			return
	
	### Init sorting and get data ###
	inner_column_name = column_name
	
	var rows: Array = table.get_rows()
	var rows_data: Array = []
	var rows_data_to_row: Dictionary
	
	
	for row in rows:
		rows_data.append(row.data)
		rows_data_to_row[row.data] = row
	
	### Sort data ###
	match sorting_type:
		TableConstants.ColumnSort.SORT_ASCENDING:
			rows_data.sort_custom(self, "_sort_ascending")
		
		TableConstants.ColumnSort.SORT_DESCENDING:
			rows_data.sort_custom(self, "_sort_descending")
			
	### Sort rows ###
	var rows_parent: Node = table._rowContainer
	
	for i in range(rows_data.size()):
		var row = rows_data_to_row[rows_data[i]]
		rows_parent.move_child(row, i)
		


func _sort_ascending(a, b):
	if a[inner_column_name] < b[inner_column_name]:
		return true
	
	return false


func _sort_descending(a, b):
	if a[inner_column_name] > b[inner_column_name]:
		return true
	
	return false
