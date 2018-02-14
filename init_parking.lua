 
local total_parking_spots = 100

local available_ps_key = "parking_spots:available"
local assigned_ps_key = "parking_spots:planes:map"


local function initialize(nb_spots)
	redis.call("DEL", available_ps_key)

	-- assigning of the available parking spots
	for i = 1, nb_spots, 1 do
		redis.call("SADD", available_ps_key, i)
	end

	redis.call("DEL", assigned_ps_key)
end

local function init_parking_spots(init_option)

	if init_option == "init" then
		initialize(total_parking_spots)
		return 0
	elseif init_option == "del" then
		initialize(0)
		return 0
	end

	error("no arguments [init|del]")
end

return init_parking_spots(ARGV[1])

