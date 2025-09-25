local cooldowns = {}

local function limit_vector(vec, max_mag)
    local mag = math.sqrt(vec.x^2 + vec.y^2 + vec.z^2)
    if mag > max_mag then
        local scale = max_mag / mag
        return {
            x = vec.x * scale,
            y = vec.y * scale,
            z = vec.z * scale
        }
    end
    return vec
end

minetest.register_tool("yeetstick:yeet_stick", {
    description = "Yeet Stick",
    inventory_image = "default_stick.png",

    on_use = function(itemstack, user, pointed_thing)
        local name = user:get_player_name()
        local time = minetest.get_us_time()

        if cooldowns[name] and time - cooldowns[name] < 1000000 then
            return itemstack
        end

        cooldowns[name] = time

        local dir = user:get_look_dir()
        local velocity = limit_vector(vector.multiply(dir, 30), 35)

        user:add_player_velocity(velocity)
        return itemstack
    end,

    on_place = function(itemstack, user, pointed_thing)
        local name = user:get_player_name()
        local time = minetest.get_us_time()

        if cooldowns[name] and time - cooldowns[name] < 1000000 then
            return itemstack
        end

        cooldowns[name] = time

        if pointed_thing and pointed_thing.ref then
            local entity = pointed_thing.ref
            local dir = user:get_look_dir()
            local velocity = limit_vector(vector.multiply(dir, 60), 75)

            if entity and entity:get_velocity() then
                entity:set_velocity(velocity)
            end
        end
        return itemstack
    end,
})
