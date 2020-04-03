--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>5.
	
	City Builder
  ]]


-- Registered cities
cidades.registered_cities = {}

-- Register city
cidades.register_city = function(city_id, def)
	cidades.registered_cities[city_id] = def
end

-- Active cities
cidades.active_cities = cidades.db.ms:get_string("active_cities")
if cidades.active_cities == "" then
	cidades.active_cities = {}
else
	cidades.active_cities = minetest.deserialize(cidades.active_cities)
end

-- Insert active city
cidades.insert_active_city = function(city_id, def)
	
	cidades.active_cities[city_id] = def
	cidades.db.ms:set_string("active_cities", minetest.serialize(cidades.active_cities))
end

-- Remove active city
cidades.remove_active_city = function(city_id, def)
	cidades.active_cities[city_id] = nil
	cidades.db.ms:set_string("active_cities", minetest.serialize(cidades.active_cities))
end

-- Create city
cidades.create_city = function(city_id, pos)
	
	local city = cidades.registered_cities[city_id]
	
	-- Minp & Maxp
	local minp = {
		x = pos.x - city.radius,
		y = pos.y - city.depth,
		z = pos.z - city.radius,
	}
	local maxp = {
		x = pos.x + city.radius,
		y = pos.y + city.height,
		z = pos.z + city.radius,
	}
	
	-- Place schem	
	minetest.place_schematic(minp, city.schem_path)
	
	-- Protect area
	local area_id = cidades.protect_area("Server city", city.name, minp, maxp)
	
	-- Insert active city
	cidades.insert_active_city(city_id, {
		name = city.name,
		minp = minp,
		maxp = maxp,
		spawn = {x=pos.x, y=pos.y+6, z=pos.z},
		area_id = area_id,
	})
	
end

minetest.register_chatcommand("create_city", {
	params = "City ID",
	description = "Create an active city",
	func = function(name, param)
		if not param or param == "" or not cidades.registered_cities[param] then
			minetest.chat_send_player(name, "Invalid City ID")
			return
		end
		
		cidades.create_city(param, minetest.get_player_by_name(name):get_pos())
		minetest.chat_send_player(name, cidades.registered_cities[param].name.." created.")
	end,
})
