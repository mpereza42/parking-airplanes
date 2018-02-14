 
redis.replicate_commands()

local available_ps_key = "parking_spots:available"
local assigned_ps_key = "parking_spots:planes:map"

local function get_parking_spot(airplane_id)

	if redis.call("EXISTS", available_ps_key) == 0 and
		redis.call("EXISTS", assigned_ps_key) == 0 then
			error("Keys not initialized")
	end

	-- get parking spot if already assigned
	local parking_spot = redis.call("HGET", assigned_ps_key, airplane_id);

	if parking_spot then
		return parking_spot
	end

	-- if parking spot is not already assigned get random one
	parking_spot = redis.call("SPOP", available_ps_key)

	if not parking_spot then
		return nil
	end

	-- assigne parking spot to requested airplane
	redis.call("HSET", assigned_ps_key, airplane_id, parking_spot)

	return parking_spot

end


return get_parking_spot(ARGV[1])

