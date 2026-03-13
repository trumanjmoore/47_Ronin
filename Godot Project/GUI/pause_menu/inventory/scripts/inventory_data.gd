class_name InventoryData extends Resource
# this will keep track of various data from the inventory

@export var slots : Array[SlotData]


# functions to help add and manipulate data
# accept item and quantity, return bool if item is pickupable
# if item is already in inventory stack it
func add_item(item: ItemData, count: int = 1) -> bool:
	# iterate over slots, check if empty, check if same item
	# TODO:consider if items are stackable, or if there is a max stack
	for slot in slots:
		if slot: 
			if slot.item_data == item:
				slot.quantity += count
				return true
	# iterate over slots, if empty slot, create new instance of item data
	for i in slots.size():
		if slots[i] == null:
			var new = SlotData.new()
			new.item_data = item
			new.quantity = count
			slots[i] = new
			return true
		
	return false
