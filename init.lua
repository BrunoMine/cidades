--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>5.
	
  ]]

cidades = {}

cidades.money_item = (minetest.settings:get("cidades_money_item") or "default:apple")

local modpath = minetest.get_modpath("cidades")

dofile(modpath.."/data_base.lua")

dofile(modpath.."/number_nodes.lua")

--dofile(modpath.."/city.lua")
dofile(modpath.."/city_builder.lua")
--dofile(modpath.."/city_stone.lua")

dofile(modpath.."/property.lua")
dofile(modpath.."/property_builder.lua")
dofile(modpath.."/property_stone.lua")

--dofile(modpath.."/teleporter.lua")

dofile(modpath.."/seller_node.lua")

