--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
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


-- Check property stone
cidades.check_property_stone = function(pos)
	local meta = minetest.get_meta(pos)
	local data = minetest.deserialize(meta:get_string("stone_data"))
	
	-- Check data base registry
	if cidades.db.check_property(data.owner) == false then
		cidades.reset_property(pos, data)
	end
end


-- Check property stones
minetest.register_abm{
        label = "check purchased property",
	nodenames = {"cidades:property_stone_purchased"},
	interval = 300,
	chance = 1,
	action = function(pos)
		cidades.check_property_stone(pos)
	end,
}
