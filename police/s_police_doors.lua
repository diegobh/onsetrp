local modelsPrison = {
	{model = 5},
	{model = 7},
	{model = 10},
	{model = 11},
	{model = 12},
	{model = 13},
	{model = 14},
	{model = 15},
	{model = 16},
	{model = 39}
}

AddEvent("OnPlayerInteractDoor", function(player, door)
	for k, v in pairs(modelsPrison) do
		if GetDoorModel(door) == v.model then
			if PlayerData[player].job == 'police' then
				SetDoorOpen(door, IsDoorOpen(door))
			else
				SetDoorOpen(door, not IsDoorOpen(door))
			end
		end
	end
end)