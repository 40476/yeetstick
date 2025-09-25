minetest.register_tool("yeet:yeet_stick", {
    description = "Yeet Stick",
    inventory_image = "default_stick.png",

    on_use = function(itemstack, user, pointed_thing)
        -- Left-click: fling player
        local dir = user:get_look_dir()
        local pos = user:get_pos()
        local velocity = vector.multiply(dir, 20)
        user:add_player_velocity(velocity)
        return itemstack
    end,

    on_place = function(itemstack, user, pointed_thing)
        -- Right-click: fling entity
        if pointed_thing and pointed_thing.ref and pointed_thing.ref:is_player() == false then
            local entity = pointed_thing.ref
            local dir = user:get_look_dir()
            local velocity = vector.multiply(dir, 60)
            if entity and entity:get_velocity then
                entity:set_velocity(velocity)
            end
        end
        return itemstack
    end,
})
