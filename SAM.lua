
-- ============================================================
-- Ashbel's SAM.lua
-- F9  = Cycle Weapons
-- F10 = Cycle Engage Sets
-- ============================================================

function get_sets()

    mote_include_version = 2
    include('Mote-Include.lua')

end


-- ============================================================
-- USER SETUP
-- ============================================================

function user_setup()

    -- Weapon selector
    state.Weapon = M{'Kusanagi','Masamune','ShiningOne','Amanomurakumo','Murasamemaru','Norifusa'}

    -- Engage selector
    state.OffenseMode:options(
        'Engage',
        'GlassCannon',
        'SubtleBlow'
    )

    state.OffenseMode:set('Engage')

    -- F9 = cycle weapon
    send_command('bind f9 gs c cycle Weapon')
	send_command('bind f10 gs c cycleback Weapon')

    -- F10 = cycle engage set
    send_command('bind f11 gs c cycle OffenseMode')
end

			--WeaponSkills
    send_command('bind ^numpad7 input /ws "Tachi: Shoha" <t>')
    send_command('bind ^numpad8 input /ws "Tachi: Fudo" <t>')
    send_command('bind ^numpad4 input /ws "Tachi: Mumei" <t>')
    send_command('bind ^numpad5 input /ws "Tachi: Jinpu" <t>')
    send_command('bind ^numpad6 input /ws "Tachi: Gekko" <t>')
    send_command('bind ^numpad1 input /ws "Tachi: Kasha" <t>')
    send_command('bind ^numpad2 input /ws "Tachi: Yukikaze" <t>')
    send_command('bind ^numpad3 input /ws "Tachi: Ageha" <t>')




-- ============================================================
-- UNLOAD
-- ============================================================

function user_unload()

    send_command('unbind f9')
    send_command('unbind f10')
	send_command('unbind f11')

end


-- ============================================================
-- GEAR SETS
-- ============================================================

function init_gear_sets()



    -- ========================================================
    -- WEAPONS
    -- ========================================================

    sets.Weapon = {}

    sets.Weapon.Kusanagi = {
        main = "Kusanagi"
    }

    sets.Weapon.Masamune = {
        main = "Masamune"
    }

    sets.Weapon.ShiningOne = {
        main = "Shining One"
    }

    sets.Weapon.Amanomurakumo = {
        main = "Amanomurakumo"
    }

    sets.Weapon.Murasamemaru = {
        main = "Murasamemaru"
    }

    sets.Weapon.Norifusa = {
        main = "Norifusa +1"
    }
-- ============================================================
-- JA's and Other Sets
-- ============================================================
	Smertrios = {}
	sets.buff.Sekkanoki = {hands="Unkai kote +3"}
    sets.buff.Sengikori = {}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate +1"}
    sets.thirdeye = {head="Unkai Kabuto +2", legs="Sakonji Haidate"}
	sets.precast.JA.Meditate = {head="Wakido Kabuto +4", hands="Sakonji Kote +3", back="Smertrios's Mantle"}

    -- ========================================================
    -- IDLE
    -- ========================================================

    sets.idle = {

        ammo="Staunch Tathlum +1",
		head="Null Masque",
		body="Adamantite Armor",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Plat. Mog. Belt",
		left_ear="Sanare Earring",
		right_ear="Hearty Earring",
		left_ring="Shneddick Ring",
		right_ring="Murky Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
}
 -- Engaged sets
    
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.

    -- ========================================================
    -- ENGAGE
    -- ========================================================

		sets.engaged = {

        ammo="Coiste Bodhar",
        head="Kasuga Kabuto +3",
        body="Kasuga Domaru +3",
        hands="Nyame Gauntlets",
        legs="Kasuga Haidate +3",
        feet="Nyame Sollerets",
		neck="Moonlight Nodowa",
        waist="Sweordfaetels +1",
		left_ear="Schere Earring",
        right_ear="Kasuga Earring +1",
		left_ring="Chirich Ring +1",
        right_ring="Chirich Ring +1",
		back="Takaha Mantle"

    }
		
		sets.engaged.GlassCannon = {

        ammo="Coiste Bodhar",
        head="Kasuga Kabuto +3",
        body="Kasuga Domaru +3",
        hands="Tatena. Gote +1",
        legs="Kasuga Haidate +3",
        feet="Ryuo Sune-Ate +1",
		neck="Moonlight Nodowa",
        waist="Sweordfaetels +1",
		left_ear="Schere Earring",
        right_ear="Kasuga Earring +1",
		left_ring="Chirich Ring +1",
        right_ring="Chirich Ring +1",
		back="Takaha Mantle"

    }
		sets.engaged.SubtleBlow = {

        ammo="Coiste Bodhar",
        head="Kasuga Kabuto +3",
        body="Dagon Breast.",
        hands="Nyame Gauntlets",
        legs="Mpaca's Hose",
		feet="Ryuo Sune-Ate +1",
		neck="Bathy Choker +1",
        waist="Sarissapho. Belt",
		left_ear="Schere Earring",
        right_ear="Digni. Earring",
		left_ring="Chirich Ring +1",
        right_ring="Chirich Ring +1",
		back="Smertrios's Mantle"

    }

sets.buff.Phalanx = {
    head = "YOUR PHALANX HEAD",
    body = "YOUR PHALANX BODY",
    hands = "YOUR PHALANX HANDS",
    legs = "YOUR PHALANX LEGS",
    feet = "YOUR PHALANX FEET"
}


--=============================================================
-- 							WS SETS
-- ============================================================
 sets.precast.WS = {
				sub="Utu Grip",
				ammo="Knobkierrie",
				head={ name="Mpaca's Cap", augments={'Path: A',}},
				body={ name="Nyame Mail", augments={'Path: B',}},
				hands="Kasuga Kote +3",
				legs={ name="Nyame Flanchard", augments={'Path: B',}},
				feet={ name="Nyame Sollerets", augments={'Path: B',}},
				neck="Fotia Gorget",
				waist="Fotia Belt",
				left_ear="Thrud Earring",
				right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
				left_ring="Sroda Ring",
				right_ring="Cornelia's Ring",
				back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
    }
	
	sets.precast.WS['Tachi: Mumei'] = {
		ammo="Knobkierrie",
		head={ name="Mpaca's Cap", augments={'Path: A',}},
		body="Sakonji Domaru +4",
		hands="Kasuga Kote +3",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Samurai's Nodowa +2",
		waist="Kentarch belt +1",
		--waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Kasuga Earring +1",
		--left_ring="Niqmaddu Ring",
		left_ring="Regal Ring",
		right_ring="Cornelia's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	
	 sets.precast.WS['Tachi: Jinpu'] = {
        sub="Utu Grip",
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Moonshade Earring",
		left_ring="Sroda Ring",
		right_ring="Cornelia's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
    }

end

-- ============================================================
-- 						WEAPON STATE HANDLER
-- ============================================================

function job_state_change(stateField, newValue, oldValue)

    if stateField == 'Weapon' then
        equip(sets.Weapon[newValue])
    end

end
-- ===============================================================
-- 							FUNCTIONS 
-- ===============================================================
function spectral_jig()

    if buffactive.sneak then
        send_command('cancel 71')
    end

end
windower.register_event('action', function(act)

    -- Someone is casting a spell
    if act.category == 4 then

        -- Phalanx = spell ID 106
        if act.param == 106 then

            -- Check all targets of the spell
            for _, target in pairs(act.targets) do

                -- The spell is targeting me
                if target.id == player.id then

                    equip(sets.buff.Phalanx)

                    add_to_chat(122, 'Incoming Phalanx - Phalanx gear equipped.')

                    return
                end
            end
        end
    end
end)



