-- Blue Mage (BLU) GearSwap - Standard standalone template
-- File location: Windower/addons/GearSwap/data/BLU.lua
-- Commands:
--   //gs c update
--   //gs c weapon Naegling
--   //gs c weapon Tizona
--   //gs c weapon Colada
--   //gs c weapons
--
-- IMPORTANT:
-- Replace the sample gear in the sets below with gear you own.
-- Weapon commands only work if the corresponding weapon set is configured below.
-- This file does not require Mote-Include.
-- • ~ = Shift
-- • ^ = Control (Ctrl)
-- • ! = Alt
-- • @ = Windows Key

function get_sets()
    -- General / idle / engaged
    sets.idle = {
        -- Replace with your idle, refresh, movement, and damage-taken gear.
        ammo="Staunch Tathlum",
        neck="Loricate Torque +1",
        left_ring="Defending Ring",
        right_ring="Shneddick Ring",
    }

    sets.engaged = {
        -- Replace with your TP / accuracy gear.
        ammo="Coiste Bodhar",
        neck="Anu Torque",
        left_ring="Chirich Ring +1",
        right_ring="Chirich Ring +1",
    }

    sets.defense = {}
    sets.defense.PDT = {
        neck="Loricate Torque +1",
        left_ring="Defending Ring",
    }
    sets.defense.MDT = {
        neck="Warder's Charm +1",
        left_ring="Defending Ring",
    }

    -- Precast: fast cast
    sets.precast = {}
    sets.precast.FC = {
        -- Add your Fast Cast gear here.
        head="Haruspex Hat",
        neck="Orunmila's Torque",
        left_ear="Loquacious Earring",
        right_ear="Etiolation Earring",
        left_ring="Prolix Ring",
    }
    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {
        -- Add BLU-specific fast cast pieces here if desired.
    })

    -- Job abilities
    sets.precast.JA = {}
    sets.precast.JA['Azure Lore'] = {
        -- Add your Azure Lore enhancement gear here.
    }
    sets.precast.JA['Chain Affinity'] = {
        -- Add Chain Affinity gear here.
    }
    sets.precast.JA['Efflux'] = {
        -- Add Efflux gear here.
    }
    sets.precast.JA['Burst Affinity'] = {
        -- Add Burst Affinity gear here.
    }
    sets.precast.JA['Diffusion'] = {
        -- Add Diffusion gear here.
    }
    sets.precast.JA['Convergence'] = {
        -- Add Convergence gear here.
    }
    sets.precast.JA['Unbridled Learning'] = {}

    -- Weaponskills
    sets.precast.WS = {
        -- General physical weaponskill set. Replace with your best WS gear.
        ammo="Coiste Bodhar",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ring="Regal Ring",
        right_ring="Epaminondas's Ring",
    }
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        -- Add your strongest Savage Blade pieces here.
    })
    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
        -- Add DEX / crit-focused pieces here.
    })
    sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS, {
        -- Add Expiacion-specific pieces here.
    })
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        -- Add Requiescat-specific pieces here.
    })
    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
        -- Add MND / magic attack pieces here.
    })

    -- Midcast sets
    sets.midcast = {}
    sets.midcast['Blue Magic'] = {
        -- General Blue Magic set. This is the fallback for all Blue Magic.
        -- For physical spells, prioritize the relevant stat (often STR/DEX),
        -- accuracy, and Blue Magic skill where appropriate.
        -- For magical spells, prioritize INT/MAB/Magic Accuracy as appropriate.
        neck="Mirage Stole +2",
        left_ear="Mache Earring +1",
        right_ear="Mache Earring +1",
    }

    sets.midcast.BlueMagicPhysical = set_combine(sets.midcast['Blue Magic'], {
        -- Add physical Blue Magic skill, accuracy, and spell-stat gear here.
    })
    sets.midcast.BlueMagicMagical = set_combine(sets.midcast['Blue Magic'], {
        -- Add INT, Magic Attack Bonus, and Magic Accuracy gear here.
    })
    sets.midcast.BlueMagicHealing = set_combine(sets.midcast['Blue Magic'], {
        -- Add MND, Healing Magic skill, and cure potency gear here.
    })
    sets.midcast.BlueMagicBuff = set_combine(sets.midcast['Blue Magic'], {
        -- Add Blue Magic skill / enhancing-buff duration gear here.
    })
    sets.midcast['Enhancing Magic'] = {
        -- Add enhancing magic skill / duration gear here.
    }
    sets.midcast['Healing Magic'] = {
        -- Add cure potency gear here.
    }
    sets.midcast['Elemental Magic'] = {
        -- Add INT / Magic Attack Bonus / Magic Accuracy gear here.
    }
    sets.midcast['Dark Magic'] = {
        -- Add Dark Magic skill / Magic Accuracy gear here.
    }

    -- Spell-specific examples. Add names exactly as they appear in game.
    sets.midcast['Cocoon'] = sets.midcast.BlueMagicBuff
    sets.midcast['Mighty Guard'] = sets.midcast.BlueMagicBuff
    sets.midcast['Pollen'] = sets.midcast.BlueMagicHealing
    sets.midcast['Wild Carrot'] = sets.midcast.BlueMagicHealing
    sets.midcast['White Wind'] = sets.midcast.BlueMagicHealing

    -- Buff gear applied after casting when the corresponding buff is active.
    sets.buff = {}
    sets.buff['Chain Affinity'] = {}
    sets.buff['Burst Affinity'] = {}
    sets.buff['Efflux'] = {}
    sets.buff['Azure Lore'] = {}
    sets.buff['Diffusion'] = {}
    sets.buff['Unbridled Learning'] = {}

    -- Optional movement set. Used while idle if you add gear here.
    sets.movement = {
        -- feet="Your movement speed feet",
    }

    -- Weapon sets. Edit these to match the exact weapons and offhands you own.
    -- BLU commonly uses a sword plus a suitable offhand; verify your own setup.
    sets.weapons = {
        Naegling = {main="Naegling", sub="Thibron"},
        Tizona   = {main="Tizona", sub="Thibron"},
        Colada   = {main="Colada", sub="Thibron"},
    }

    state = state or {}
    state.weapon = state.weapon or 'Naegling'
    state.defenseMode = 'None'

    -- Lockstyle and macro book. Set these to your preference.
    send_command('wait 2; input /macro book 1; wait 1; input /lockstyleset 101')
end

function precast(spell)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Blue Magic' then
            equip(sets.precast.FC['Blue Magic'] or sets.precast.FC)
        else
            equip(sets.precast.FC)
        end
    elseif spell.type == 'WeaponSkill' then
        equip(sets.precast.WS)
        if sets.precast.WS[spell.english] then
            equip(sets.precast.WS[spell.english])
        end
    elseif spell.type == 'JobAbility' then
        if sets.precast.JA[spell.english] then
            equip(sets.precast.JA[spell.english])
        end
    end
end

function midcast(spell)
    if spell.skill == 'Blue Magic' then
        -- Default safely to the general Blue Magic set.
        equip(sets.midcast['Blue Magic'])

        -- Apply manually defined spell-specific sets when present.
        if sets.midcast[spell.english] then
            equip(sets.midcast[spell.english])
        end

        -- Optional spell lists: add spell names to these lists to classify them.
        if is_in_list(spell.english, blue_physical_spells) then
            equip(sets.midcast.BlueMagicPhysical)
        elseif is_in_list(spell.english, blue_magical_spells) then
            equip(sets.midcast.BlueMagicMagical)
        elseif is_in_list(spell.english, blue_healing_spells) then
            equip(sets.midcast.BlueMagicHealing)
        elseif is_in_list(spell.english, blue_buff_spells) then
            equip(sets.midcast.BlueMagicBuff)
        end

        -- Reapply an exact spell set last so it takes priority over categories.
        if sets.midcast[spell.english] then
            equip(sets.midcast[spell.english])
        end
    elseif sets.midcast[spell.skill] then
        equip(sets.midcast[spell.skill])
    end
end

-- Put the Blue Magic spell names you use into the appropriate lists.
-- The general Blue Magic set still works if these lists are left empty.
blue_physical_spells = blue_physical_spells or {
    -- 'Sudden Lunge', 'Thrashing Assault', 'Barbed Crescent',
}
blue_magical_spells = blue_magical_spells or {
    -- 'Spectral Floe', 'Entomb', 'Anvil Lightning',
}
blue_healing_spells = blue_healing_spells or {
    -- 'White Wind', 'Pollen', 'Wild Carrot',
}
blue_buff_spells = blue_buff_spells or {
    -- 'Cocoon', 'Mighty Guard', 'Refueling',
}

function is_in_list(name, list)
    for _, spell_name in ipairs(list) do
        if spell_name == name then
            return true
        end
    end
    return false
end

function aftercast(spell)
    equip_current_set()
end

function status_change(new, old)
    equip_current_set()
end

function buff_change(name, gain, buff_table)
    equip_current_set()
end

function self_command(command)
    local args = {}
    for word in command:gmatch('%S+') do
        table.insert(args, word)
    end

    if args[1] == 'weapon' and args[2] then
        if sets.weapons[args[2]] then
            state.weapon = args[2]
            add_to_chat(122, 'BLU weapon set: ' .. state.weapon)
            equip_current_set()
        else
            add_to_chat(123, 'Unknown BLU weapon set: ' .. args[2])
            add_to_chat(123, 'Available sets: Naegling, Tizona, Colada (edit sets.weapons to customize)')
        end
    elseif args[1] == 'weapons' then
        add_to_chat(122, 'BLU weapon set: ' .. (state.weapon or 'Naegling'))
    elseif args[1] == 'pdt' then
        state.defenseMode = 'PDT'
        equip_current_set()
    elseif args[1] == 'mdt' then
        state.defenseMode = 'MDT'
        equip_current_set()
    elseif args[1] == 'defenseoff' then
        state.defenseMode = 'None'
        equip_current_set()
    elseif args[1] == 'idle' or args[1] == 'update' then
        equip_current_set()
    end
end

function equip_current_set()
    if not player then return end

    local set_to_equip
    if state and state.defenseMode and state.defenseMode ~= 'None' then
        set_to_equip = sets.defense[state.defenseMode] or {}
    elseif player.status == 'Engaged' then
        set_to_equip = sets.engaged
    else
        set_to_equip = sets.idle
    end

    if state and state.weapon and sets.weapons[state.weapon] then
        set_to_equip = set_combine(set_to_equip, sets.weapons[state.weapon])
    end

    equip(set_to_equip)
end

function file_unload()
    send_command('unbind')
end
