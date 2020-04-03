--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>5.
	
	Data Base
  ]]

local mod_storage = minetest.get_mod_storage()

cidades.db = {}


-- Set City def
cidades.db.set_city = function(city_name, def)
	mod_storage:set_string("city_"..city_name, minetest.serialize(def))
end

-- Get City def
cidades.db.get_city = function(city_name)
	return minetest.deserialize(mod_storage:get_string("city_"..city_name))
end


-- Set Property def
cidades.db.set_property = function(owner, def)
	mod_storage:set_string("property_"..owner, minetest.serialize(def))
end

-- Get Property def
cidades.db.get_property = function(owner)
	return minetest.deserialize(mod_storage:get_string("property_"..owner))
end

-- Check Property
cidades.db.check_property = function(owner)
	if mod_storage:get_string("property_"..owner) ~= "" then
		return true
	end
	return false
end


-- Active cities
cidades.update_active_cities = function(city_name, status)
	cidades.active_cities[city_name] = status
	mod_storage:set_string("active_cities", minetest.serialize(cidades.active_cities))
end
