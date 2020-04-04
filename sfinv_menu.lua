--[[
	Mod Cidades for Minetest
	Copyright (C) 2020 BrunoMine (https://github.com/BrunoMine)
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>5.
	
	Sfinv_Menu
  ]]

local formspec_with_land = "size[6,4]"
	..default.gui_bg
	..default.gui_bg_img
	.."label[0.5,0;Choose a city]"
	.."textlist[0.5,0.8;4.8,3;city;]"


local show_formspec = function(player)
	local name = player:get_player_name()
	if player:get_attribute("cidades:teleporter_choose") ~= nil then
		minetest.show_formspec(name, "cidades:my_land", formspec.."button_exit[1,4.2;4,1;teleport;Go]")
	else
		minetest.show_formspec(name, "cidades:my_land", formspec)
	end
end


minetest.register_on_player_receive_fields(function(player, formname, fields)

	if formname == "cidades:my_land" then
		local name = player:get_player_name()
		
		if fields.sell then
			
			minetest.show_formspec(name, "cidades:sell_my_land", "size[5,2.8]"
				..default.gui_bg
				..default.gui_bg_img
				.."label[0,0;Are you sure? "
				.."\nAll items and blocks that are on "
				.."\nthe land will be removed automatically."
				.."]"
				.."button_exit[0,2;2,1;yes;Yes]"
				.."button_exit[3,2;2,1;no;No]"
			)
			
		end
		
	end
	
	if formname == "cidades:sell_my_land" then
		local name = player:get_player_name()
		
		if fields.yes then
			if cidades.db.check_property(name) == true then
				-- Remove registry
				cidades.db.reset_property(name)
				minetest.chat_send_player(name, "Your land has been sold.")
			end
		end
	end
end)


-- Sfinv Buttom
sfinv_menu.register_button("cidades:my_land", {
	title = "My Property", 
	icon = "default_apple.png", 
	func = function(player) 
		local name = player:get_player_name()
		
		if cidades.db.check_property(name) == false then
			minetest.show_formspec(name, "cidades:my_land", "size[5,1]"
				..default.gui_bg
				..default.gui_bg_img
				.."label[0.5,0;You do not have a property."
				.."\nBuy a property in a city.]")
			return
		else
			local data = cidades.db.get_property(name)
			local city = cidades.active_cities[data.city_id] or {}
			local city_name = city.name or "No defined"
			
			minetest.show_formspec(name, "cidades:my_land", "size[3,2.8]"
				..default.gui_bg
				..default.gui_bg_img
				.."label[0,0;My Property"
				.."\nCity: "..city_name
				.."\nPrice: "..data.cost
				.."]"
				.."button[0,2;3,1;sell;Sell my property]"
			)
			return
		end
	end,
})
