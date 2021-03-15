local stageAssets = {
    {
        'basement',
        'cellar',
        'burning_basement',
        'basement_greed'
    },
    {
        'basement',
        'cellar',
        'burning_basement',
        'caves_greed'
    },
    {
        'caves',
        'catacombs',
        'flooded_caves',
        'depths_greed'
    },
    {
        'caves',
        'catacombs',
        'flooded_caves',
        'womb_greed'
    },
    {
        'depths',
        'necropolis',
        'dank_depths',
        'sheol_greed'
    },
    {
        'depths',
        'necropolis',
        'dank_depths',
        'the_shop'
    },
    {
        'womb',
        'utero',
        'scarred_womb',
        'ultra_greed'
    },
    {
        'womb',
        'utero',
        'scarred_womb'
    },
    {
        'blue_womb',
        'blue_womb',
        'blue_womb'
    },
    {
        'sheol',
        'cathedral'
    },
    {
        'dark_room',
        'chest'
    },
    {
        'void',
        'void'
    }
}

local characterAssets = {
    'isaac',
    'magdalene',
    'cain',
    'judas',
    'blue_baby',
    'eve',
    'samsom',
    'azazel',
    'lazarus',
    'eden',
    'the_lost',
    'lazarus2',
    'black_judas',
    'lilith',
    'keeper',
    'apollyon',
    'the_forgotten',
    'the_soul'
}

function StageToDiscordAsset(stage, stageType)
    return stageAssets[stage][stageType + 1] or 'iamerror'
end

function CharacterToDiscordAsset(character)
    return characterAssets[character + 1] or 'iamerror'
end