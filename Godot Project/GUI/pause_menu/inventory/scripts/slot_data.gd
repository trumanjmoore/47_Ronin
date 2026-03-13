class_name SlotData extends Resource
# makes it easier to track inventory data

# take in item data we defined over in item_data.gd
@export var item_data : ItemData
# initialize item quantity
@export var quantity : int = 0 : set = set_quantity

func set_quantity(value:int):
	quantity = clampi(value, 0, item_data.max_capacity)
