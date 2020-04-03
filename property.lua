--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>5.
	
	Property
  ]]


cidades.property = {}


-- Radius
cidades.property.radius = {
	["0"] = 3, 
	["1"] = 4, 
	["2"] = 5, 
	["3"] = 6, 
	["4"] = 7, 
	["5"] = 8, 
	["6"] = 9, 
	["7"] = 10, 
	["8"] = 11, 
	["9"] = 12, 
}
cidades.property.radius_i = {
	["3"] = 0, 
	["4"] = 1, 
	["5"] = 2, 
	["6"] = 3, 
	["7"] = 4, 
	["8"] = 5, 
	["9"] = 6, 
	["10"] = 7, 
	["11"] = 8, 
	["12"] = 9, 
}

-- Height
cidades.property.height = {
	["0"] = 3, 
	["1"] = 5, 
	["2"] = 8, 
	["3"] = 10, 
	["4"] = 12, 
	["5"] = 14, 
	["6"] = 16, 
	["7"] = 18, 
	["8"] = 20, 
	["9"] = 25, 
}
cidades.property.height_i = {
	["3"] = 0, 
	["5"] = 1, 
	["8"] = 2, 
	["10"] = 3, 
	["12"] = 4, 
	["14"] = 5, 
	["16"] = 6, 
	["18"] = 7, 
	["20"] = 8, 
	["25"] = 9, 
}

-- Get data node
cidades.property.get_data_pos = function(pos, data_type, def)
	def = def or 0	
	
	if data_type == "core" then
		return {
			x = pos.x, 
			y = pos.y - def, 
			z = pos.z
		}
	elseif data_type == "cost10x" then
		return {
			x = pos.x - 1, 
			y = pos.y - def, 
			z = pos.z - 1
		}
	elseif data_type == "cost100x" then
		return {
			x = pos.x - 1, 
			y = pos.y - def, 
			z = pos.z
		}
	elseif data_type == "cost1000x" then
		return {
			x = pos.x - 1, 
			y = pos.y - def, 
			z = pos.z + 1
		}
	elseif data_type == "height" then
		return {
			x = pos.x, 
			y = pos.y - def, 
			z = pos.z + 1
		}
	elseif data_type == "radius" then
		return {
			x = pos.x, 
			y = pos.y - def, 
			z = pos.z - 1
		}
	end
end

-- Get property data
cidades.property.get_data = function(pos)
	local height = cidades.property.height[tostring(cidades.number_node[minetest.get_node(cidades.property.get_data_pos(pos, "height")).name])]
	local radius = cidades.property.radius[tostring(cidades.number_node[minetest.get_node(cidades.property.get_data_pos(pos, "radius")).name])]
	local cost10x = tostring(cidades.number_node[minetest.get_node(cidades.property.get_data_pos(pos, "cost10x")).name])
	local cost100x = tostring(cidades.number_node[minetest.get_node(cidades.property.get_data_pos(pos, "cost100x")).name])
	local cost1000x = tostring(cidades.number_node[minetest.get_node(cidades.property.get_data_pos(pos, "cost1000x")).name])
	local cost = tonumber(cost1000x..cost100x..cost10x.."0")
	
	return {
		radius = radius,
		height = height,
		cost = cost,
	}
end


