class_name InventoryUI extends Control

# reference to the scene file
# load reference to scene when script loads
# use that to instantiate more of those as needed
const INVENTORY_SLOT = preload("res://GUI/pause_menu/inventory/inventory_slot.tscn")

# player inventory data
@export var data : InventoryData 


func _ready():
	PauseMenu.shown.connect(update_inventory)
	PauseMenu.hidden.connect(clear_inventory)
	clear_inventory()  #clear inventory when we start the game
	pass

#need a way to clear invenotry
func clear_inventory():
	for c in get_children():
		c.queue_free()

# need a way to update it
# create button, add to gridcontainer, assign slot data
func update_inventory():
	for s in data.slots:
		var new_slot = INVENTORY_SLOT.instantiate()
		add_child(new_slot)   #adds child instantiated above to gridcontainer
		new_slot.slot_data = s  # calls set_slot_data in inventory slot ui
	
	
