--[[ Ashbel's 
    WAR.lua - Fresh Weapon-Swap GearSwap
    Weapons:
      Chango             - Great Axe
      Laphria            - Great Axe
      Helheim            - Great Sword
      Agwu's Greatsword  - Great Sword
      Naegling           - Sword / Shield
      Ikenga's Axe       - Axe / Shield
      Shining One        - Polearm
      Loxotic Mace +1    - Club / Shield

    Weapon selection:
      //gs c weapon Chango
      //gs c weapon Laphria
      //gs c weapon Helheim
      //gs c weapon Agwu
      //gs c weapon Naegling
      //gs c weapon Ikenga
      //gs c weapon Shining
      //gs c weapon Loxotic

    Weapon-skill weapon routing:
      Resolution   -> current Great Sword (Helheim or Agwu's Greatsword)
      Savage Blade -> Naegling
      Mistral Axe  -> Ikenga's Axe
      Calamity     -> Ikenga's Axe
      Judgment     -> Loxotic Mace +1

    NOTE:
      The armor sets below are a clean baseline. Replace individual pieces
      with your own augmented/BiS pieces as needed.
]]

function get_sets()
    mote_include_version = 2

    include('Mote-Include.lua')
end

function job_setup()
    -- Weapon modes.
    state.Weapon = M{['description']='Weapon',
        'Chango',
        'Laphria',
        'Helheim',
        'Agwu',
        'Naegling',
        'Ikenga',
        'Shining',
        'Loxotic'}

    -- WS that require a particular weapon.
    ws_weapon = {
        ['Resolution']   = 'GreatSword',
        ['Savage Blade'] = 'Naegling',
        ['Mistral Axe']  = 'Ikenga',
        ['Calamity']     = 'Ikenga',
        ['Judgment']     = 'Loxotic',
    }
end

function user_setup()
    state.OffenseMode:options('Normal','Acc')
    state.HybridMode:options('Normal','DT')
    state.IdleMode:options('Normal','DT')

    select_default_macro_book()

    -- Change weapon with F10/F11 if desired.
    send_command('bind f9 gs c cycle Weapon')
    send_command('bind f10 gs c cycleback Weapon')

    -- Uncomment if you want a direct hotkey for Naegling.
    -- send_command('bind f12 gs c set Weapon Naegling')
end

function file_unload()
    send_command('unbind f10')
    send_command('unbind f11')
    -- send_command('unbind f12')
end

function init_gear_sets()

    --------------------------------------------------------------------------
    -- WEAPONS
    --------------------------------------------------------------------------

    sets.weapons = {}

    sets.weapons.Chango = {
        main="Chango",
        sub="Utu Grip"
    }

    sets.weapons.Laphria = {
        main="Laphria",
        sub="Utu Grip"
    }

    sets.weapons.Helheim = {
        main="Helheim",
        sub="Utu Grip"
    }

    sets.weapons.Agwu = {
        main="Agwu's Claymore",
        sub="Utu Grip"
    }

    sets.weapons.Naegling = {
        main="Naegling",
        sub="Blurred Shield +1"
    }

    sets.weapons.Ikenga = {
        main="Ikenga's Axe",
        sub="Blurred Shield +1"
    }

    sets.weapons.Shining = {
        main="Shining One",
        sub="Utu Grip"
    }

    sets.weapons.Loxotic = {
        main="Loxotic Mace +1",
        sub="Blurred Shield +1"
    }

    --------------------------------------------------------------------------
    -- IDLE
    --------------------------------------------------------------------------

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings",
        neck="Warder's Charm +1",
        waist="Carrier's Sash",
        left_ear="Etiolation Earring",
        right_ear="Genmei Earring",
        left_ring="Defending Ring",
        right_ring="Shneddick Ring",
        back="Null Shawl"
    }

    sets.idle.DT = set_combine(sets.idle, {
        neck="Warder's Charm +1",
        left_ring="Defending Ring",
        right_ring="Gelatinous Ring +1"
    })

    --------------------------------------------------------------------------
    -- ENGAGED / TP
    --------------------------------------------------------------------------

		sets.engaged = { --DA/STP/DT/Haste
			ammo="Coiste Bodhar", --3
			head="Boii Mask +3", --7/0/11
			body="Sakpata's Plate", --8/0/10
			hands="Sakpata's Gauntlets", --8/8/8
			legs="Pumm. Cuisses +4", --11/0/4
			feet="Pumm. Calligae +4", --9/4/0/4
			--neck={ name="War. Beads +2", augments={'Path: A',}}, --7/0/0/0
			neck="Vim Torque +1",
			waist="Sailfi Belt +1", --5/0/0/9
			left_ear="Schere Earring", --6/5/0/0
			right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','Crit.hit rate+4',}}, --8/0/0/0
			left_ring="Moonlight Ring", 
			right_ring="Moonlight Ring",
			back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}, --10/0/10/0
			
			--101/-/55%DT/26%
	}

    sets.engaged.Acc = set_combine(sets.engaged, {
        ammo="Ginsen",
        head="Flam. Zucchetto +2",
        neck="Warrior's Bead Necklace +2",
        left_ear="Telos Earring",
        right_ear="Crep. Earring +1",
        waist="Ioskeha Belt +1"
    })

    sets.engaged.DT = set_combine(sets.engaged, {
        head="Sakpata's Helm",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings",
        neck="Warder's Charm +1",
        left_ring="Defending Ring",
        right_ring="Gelatinous Ring +1"
    })

    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.DT)

    --------------------------------------------------------------------------
    -- GENERAL WS
    --------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Knobkierrie",
        head="Agoge Mask +4",
        body="Nyame Mail",
        hands="Boii Mufflers +3",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Warrior's Bead Necklace +2",
        waist="Sailfi Belt +1",
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back="Cichol's Mantle"
    }

    --------------------------------------------------------------------------
    -- RESOLUTION
    -- Helheim / Agwu's Greatsword
    --------------------------------------------------------------------------

    sets.precast.WS.Resolution = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head="Agoge Mask +4",
        body="Nyame Mail",
        hands="Boii Mufflers +3",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Warrior's Bead Necklace +2",
        waist="Sailfi Belt +1",
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back="Cichol's Mantle"
    })

    --------------------------------------------------------------------------
    -- SAVAGE BLADE / NAEGLING
    --------------------------------------------------------------------------

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head="Agoge Mask +4",
        body="Nyame Mail",
        hands="Boii Mufflers +3",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Warrior's Bead Necklace +2",
        waist="Sailfi Belt +1",
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back="Cichol's Mantle"
    })

    --------------------------------------------------------------------------
    -- MISTRAL AXE / IKENGA'S AXE
    --------------------------------------------------------------------------

    sets.precast.WS['Mistral Axe'] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head="Agoge Mask +4",
        body="Nyame Mail",
        hands="Boii Mufflers +3",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Warrior's Bead Necklace +2",
        waist="Sailfi Belt +1",
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back="Cichol's Mantle"
    })

    --------------------------------------------------------------------------
    -- CALAMITY / IKENGA'S AXE
    --------------------------------------------------------------------------

    sets.precast.WS['Calamity'] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head="Agoge Mask +4",
        body="Nyame Mail",
        hands="Boii Mufflers +3",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Warrior's Bead Necklace +2",
        waist="Sailfi Belt +1",
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back="Cichol's Mantle"
    })

    --------------------------------------------------------------------------
    -- JUDGMENT / LOXOTIC MACE +1
    --------------------------------------------------------------------------

    sets.precast.WS.Judgment = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head="Agoge Mask +4",
        body="Nyame Mail",
        hands="Boii Mufflers +3",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Warrior's Bead Necklace +2",
        waist="Sailfi Belt +1",
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back="Cichol's Mantle"
    })

    --------------------------------------------------------------------------
    -- JOB ABILITY SETS
    --------------------------------------------------------------------------

    sets.precast.JA = {}

    sets.precast.JA['Mighty Strikes'] = {
        hands="Agoge Mufflers +4"
    }

    sets.precast.JA['Berserk'] = {
        feet="Pumm. Calligae +3"
    }

    sets.precast.JA['Aggressor'] = {
        head="Pummeler's Mask +3"
    }

    sets.precast.JA['Warcry'] = {
        head="Agoge Mask +4"
    }

    sets.precast.JA['Blood Rage'] = {
        body="Boii Lorica +3"
    }

    sets.precast.JA['Retaliation'] = {
        hands="Pummeler's Mufflers +3"
    }

    sets.precast.JA['Provoke'] = {
        body="Emicho Haubert +1"
    }

    --------------------------------------------------------------------------
    -- BUFF SETS
    --------------------------------------------------------------------------

    sets.buff = {}

    sets.buff.Berserk = {
        feet="Pumm. Calligae +3"
    }

    sets.buff.Aggressor = {
        head="Pummeler's Mask +3"
    }

    sets.buff.Retaliation = {
        hands="Pummeler's Mufflers +3"
    }

    sets.buff['Warcry'] = {
        head="Agoge Mask +4"
    }

end

-------------------------------------------------------------------------------
-- PRECAST
-------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)

    if spell.type == 'WeaponSkill' then

        -- Equip the requested WS set first.
        if sets.precast.WS[spell.english] then
            equip(sets.precast.WS[spell.english])
        else
            equip(sets.precast.WS)
        end

        -- Force the correct weapon for the WS.
        if ws_weapon[spell.english] then
            equip_weapon_for_ws(ws_weapon[spell.english])
        end

        return
    end

    -- JA handling is supplied by Mote-Include.
end

-------------------------------------------------------------------------------
-- AFTERCAST
-------------------------------------------------------------------------------

function job_aftercast(spell, action, spellMap, eventArgs)

    if spell.type == 'WeaponSkill' then
        equip_selected_weapon()
    end
end

-------------------------------------------------------------------------------
-- STATUS CHANGE
-------------------------------------------------------------------------------

function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        equip_selected_weapon()
    end
end

-------------------------------------------------------------------------------
-- STATE CHANGE
-------------------------------------------------------------------------------

function job_state_change(field, newValue, oldValue)

    if field == 'Weapon' then
        if player.status == 'Engaged' then
            equip_selected_weapon()
        else
            equip_selected_weapon()
        end

        add_to_chat(122, 'WAR Weapon: '..state.Weapon.value)
    end
end

-------------------------------------------------------------------------------
-- CUSTOM COMMANDS
-------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)

    if cmdParams[1] == 'weapon' and cmdParams[2] then
        local weapon = cmdParams[2]

        if weapon == 'Chango' then
            state.Weapon:set('Chango')
        elseif weapon == 'Laphria' then
            state.Weapon:set('Laphria')
        elseif weapon == 'Helheim' then
            state.Weapon:set('Helheim')
        elseif weapon == 'Agwu' then
            state.Weapon:set('Agwu')
        elseif weapon == 'Naegling' then
            state.Weapon:set('Naegling')
        elseif weapon == 'Ikenga' then
            state.Weapon:set('Ikenga')
        elseif weapon == 'Shining' then
            state.Weapon:set('Shining')
        elseif weapon == 'Loxotic' then
            state.Weapon:set('Loxotic')
        end

        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------
-- WEAPON HELPERS
-------------------------------------------------------------------------------

function equip_selected_weapon()

    if state.Weapon.value == 'Chango' then
        equip(sets.weapons.Chango)

    elseif state.Weapon.value == 'Laphria' then
        equip(sets.weapons.Laphria)

    elseif state.Weapon.value == 'Helheim' then
        equip(sets.weapons.Helheim)

    elseif state.Weapon.value == 'Agwu' then
        equip(sets.weapons.Agwu)

    elseif state.Weapon.value == 'Naegling' then
        equip(sets.weapons.Naegling)

    elseif state.Weapon.value == 'Ikenga' then
        equip(sets.weapons.Ikenga)

    elseif state.Weapon.value == 'Shining' then
        equip(sets.weapons.Shining)

    elseif state.Weapon.value == 'Loxotic' then
        equip(sets.weapons.Loxotic)
    end
end

function equip_weapon_for_ws(weapon)

    if weapon == 'GreatSword' then

        -- Keep whichever Great Sword the player selected.
        if state.Weapon.value == 'Helheim' then
            equip(sets.weapons.Helheim)
        elseif state.Weapon.value == 'Agwu' then
            equip(sets.weapons.Agwu)
        else
            -- Resolution defaults to Agwu's Greatsword if no GS mode
            -- was selected.
            equip(sets.weapons.Agwu)
        end

    elseif weapon == 'Naegling' then
        equip(sets.weapons.Naegling)

    elseif weapon == 'Ikenga' then
        equip(sets.weapons.Ikenga)

    elseif weapon == 'Loxotic' then
        equip(sets.weapons.Loxotic)
    end
end

-------------------------------------------------------------------------------
-- DEFAULT MACRO BOOK
-------------------------------------------------------------------------------

function select_default_macro_book()
    -- Change these if your WAR macros live elsewhere.
    set_macro_page(1, 1)
end
