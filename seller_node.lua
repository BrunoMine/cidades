--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
	
	Seller node
  ]]


-- Access
local seller_access = function(player, pos)
	-- Set pos
	player:set_attribute("cidades:seller_pos", minetest.serialize(pos))
	
	local name = player:get_player_name()
	
	local data = cidades.property.get_data({x=pos.x, y=pos.y-3, z=pos.z})
	local width = (data.radius * 2) + 1
	
	-- Button status
	local text = "Make sure you can pay."
	if cidades.db.check_property(name) == true then
		text = minetest.colorize("#ff0707", "You already own land. Sell it to buy that one.")
	end
	
	minetest.show_formspec(name, "cidades:seller", 
		"size[5,3]"
		.."label[0,-0.15;Land for sale"
		.."\nHeight: "..data.height
		.."\nWidth: "..width
		.."\nTotal buildable area: "..(width*width*(data.height)).." blocks"
		.."\nCost: "..data.cost
		.."\n"..text.."]"
		.."button_exit[0,2.35;5,1;buy;Buy]"
	)
	
end


minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "cidades:seller" then
		local name = player:get_player_name()
		local pos = minetest.deserialize(player:get_attribute("cidades:seller_pos"))
		local data = cidades.property.get_data({x=pos.x, y=pos.y-3, z=pos.z})
		
		if fields.buy then
			-- Check property
			if cidades.db.check_property(name) == true then
				return minetest.chat_send_player(name, "You already own land. Sell it to buy that one.")
			end
			
			-- Check payment
			if player:get_inventory():contains_item("main", cidades.money_item.." "..data.cost) == false then
				return minetest.chat_send_player(name, "You can not pay that.")
			end
			
			-- Get payment
			player:get_inventory():remove_item("main", cidades.money_item.." "..data.cost)
			minetest.remove_node(pos)
			
			cidades.set_owner(player, {x=pos.x, y=pos.y-3, z=pos.z}, data)
			
			minetest.chat_send_player(name, "Land purchased.")
		end
	end
end)


-- Seller node
minetest.register_node("cidades:seller", {
	description = "Seller",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_wood.png^default_coal_lump.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2},
	
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		seller_access(clicker, pos)
	end,
})
