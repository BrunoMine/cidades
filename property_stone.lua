--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>5.
	
	Property Stone
  ]]


-- Property Stone for Sale
minetest.register_node("cidades:property_stone_for_sale", {
	description = "Property Stone",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_stone.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})


-- Property Stone Purchased
minetest.register_node("cidades:property_stone_purchased", {
	description = "Property Stone Purchased",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_stone.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})
