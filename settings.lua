data:extend{
    -- Remove combat robots
    {
        name = 'uncl:uh-remove-combat-robots',
        type = 'bool-setting',
        setting_type = 'startup',
        default_value = 'true',
        order = 'a'
    },
    -- Remove discharge defense
    {
        name = 'uncl:uh-remove-discharge-defense',
        type = 'bool-setting',
        setting_type = 'startup',
        default_value = 'true',
        order = 'b'
    },
    -- Remove the beacon item (along with its technology)
    {
        name = 'uncl:uh-remove-beacons',
        type = 'bool-setting',
        setting_type = 'startup',
        default_value = 'true',
        order = 'c'
    },
    -- Reduces the collision box for solar panel so you can squeak through in between them
    {
        name = 'uncl:uh-squeak-solar-panels',
        type = 'bool-setting',
        setting_type = 'startup',
        default_value = 'true',
        order = 'd'
    }  
}
