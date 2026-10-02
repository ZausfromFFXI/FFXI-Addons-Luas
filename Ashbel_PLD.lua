function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function user_setup()
    state.WeaponskillMode:options('Duban', 'Aegis', 'Cleave')
	send_command('@wait 1; bind f9 gs c cycle WeaponskillMode')
    send_command('@wait 2; unbind f10')
    send_command('@wait 2; unbind f11')
	send_command('@wait 2; unbind f12')
	add_to_chat(122, 'Press [F9] to Toggle Shields.')
	display_modes()
end

include('CastStill.lua')

------------------------------------------------------------------------------------------------------
-- job versions called from handle_actions() in Mote-Include.lua.
------------------------------------------------------------------------------------------------------
-- Precast
------------------------------------------------------------------------------------------------------

function job_post_precast(spell, action, spellMap, eventArgs)

	local heal
	local abil_recasts = windower.ffxi.get_ability_recasts()

	heal = spell.name

	if (spell.english:startswith('Cure') or spell.english:startswith('Protect')) and abil_recasts[150] == 0 and not (buffactive[621] or false) then
		cancel_spell()
		send_command("@wait 0.1; input /ja 'Majesty' <me>")
		send_command('@wait 2; input /ja "'..heal..'" <me>')
	end

    if midaction() then
        return optional_value
    end

end

------------------------------------------------------------------------------------------------------
-- Midcasts -- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
------------------------------------------------------------------------------------------------------

function job_post_midcast(spell, action, spellMap, eventArgs)

	if no_skill_spells_list:contains(spell.name) then
		equip(sets.midcast['Enhancing Magic'])
	end

end

------------------------------------------------------------------------------------------------------
-- Aftercasts
------------------------------------------------------------------------------------------------------

function job_post_aftercast(spell, action, spellMap, eventArgs)

	if (spell.action_type == 'Magic') and spell.english ~= "Phalanx" and not buffactive[116] then
		windower.add_to_chat(4, "*** Phalanx is off!!! ***")
	end

	Engaged_Idle(spell)

end


function job_aftercast(spell, action, spellMap, eventArgs)

    Engaged_Idle(spell)

end

------------------------------------------------------------------------------------------------------
-- Logic for Engaged and Idle Statuses.
------------------------------------------------------------------------------------------------------

function Engaged_Idle(spell, action, spellMap, eventArgs)

    sets.engaged = {}

	sets.engaged.normal = {}
    sets.engaged.normal['Duban'] = set_combine(sets.normal, sets.duban)
    sets.engaged.normal['Aegis'] = set_combine(sets.normal, sets.aegis)
	sets.engaged.normal['Cleave'] = set_combine(sets.normal, sets.dagger)

    if (player.status == 'Engaged') then
			equip(sets.engaged.normal[state.WeaponskillMode.value])

    elseif (player.status == 'Idle') then
		if state.WeaponskillMode.value == 'Cleave' then
			equip(set_combine(sets.engaged.normal['Duban']), sets.cleave)
		else
        	equip(sets.engaged.normal[state.WeaponskillMode.value])
		end
	end

	handle_equipping_gear(player.status)

end


------------------------------------------------------------------------------------------------------
-- Changes Gearsets when F9/F10 is Toggled in Real Time.
------------------------------------------------------------------------------------------------------

function job_state_change(stateField, newValue, oldValue)

    if stateField == 'WeaponskillMode' then 
		if newValue == 'Duban' then
			equip(sets.duban)
		elseif newValue == 'Aegis' then
			equip(sets.aegis)
		elseif newValue == 'Cleave' then
			equip(sets.dagger)
        end
    end

    Engaged_Idle(spell)

end

------------------------------------------------------------------------------------------------------
-- Offense Mode for on Screen Display.
------------------------------------------------------------------------------------------------------

player.defense = 1

function display_modes()

    state.ShowStatus = M{['description']='Visible Status Box', 'True', 'False'}
    ShowStatus_txt = {}
    ShowStatus_txt.pos = {}
    ShowStatus_txt.pos.x = 1150
    ShowStatus_txt.pos.y = 1
    ShowStatus_txt.text = {}
    ShowStatus_txt.text.font = 'Arial'
    ShowStatus_box = texts.new('${value}', ShowStatus_txt)

    windower.raw_register_event('prerender',function()
        if state.ShowStatus.value == 'True' then
			ShowStatus_box.value ="Weapon Mode: "..state.WeaponskillMode.value..
								   "     Defense: "..player.defense
            ShowStatus_box:visible(true)
        else
            ShowStatus_box:visible(false)
        end

    end)
end

------------------------------------------------------------------------------------------------------
-- Checks Which Set To Use When Buffed/Debuffed.
------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.

function job_buff_change(buff,gain)

    local name = buff:lower()

    if state.Buff[buff] then
    	state.Buff[buff] = gain
    end
		
	if buff == "Phalanx" then
		if gain then
            handle_equipping_gear(player.status)
		end

	--[[elseif buff == "Defense Down" then
		if gain then
			send_command("@input /item 'Panacea' <me>")
        else
			send_command("@input /ma 'Cure IV' <me>")
		end]]

	end

end

function job_setup()
	lockstyleset = 107
	select_default_macro_book()
    set_lockstyle()

end
function select_default_macro_book()
    if player.sub_job == 'SCH' then
        set_macro_page(3, 7)
    else
        set_macro_page(1, 7)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end

------------------------------------------------------------------------------------------------------
-- Gearsets
------------------------------------------------------------------------------------------------------

function init_gear_sets()

	sets.duban = {main="Burtgang", sub="Duban"}
    sets.aegis = {main="Burtgang", sub="Aegis"}
	sets.dagger = {main="Malevolence", sub="Duban"}

	sets.normal = { --capped DT 50, -12 ECD (Cap 10)
        ammo="Eluder's Sachet", --5 ECD +2 DT
		head="Null Masque",
        --head={ name="Chev. Armet +3", priority=1},--11
        body={ name="Adamantite Armor", priority=1},--20
        hands="Chev. Gauntlets +3", --11
        legs="Chev. Cuisses +3", --13
        feet="Chev. Sabatons +3",
        neck={ name="Warder's Charm +1", augments={'Path: A',}}, --5% absorb dmg
        waist={ name="Plat. Mog. Belt", priority=1}, --3
        left_ear={ name="Alabaster Earring", priority=1}, --5 DT
        right_ear="Chev. Earring +1",
        left_ring="Fortified Ring", --7 ECD and MDT 5
        right_ring="Shadow Ring",
        back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
    }

	sets.idle = sets.engaged

	sets.cleave = {
		head="Null Masque",
		neck="Bathy Choker +1",
		feet="Hippo. Socks +1",
		waist={ name="Plat. Mog. Belt", priority=1},
		back={ name="Moonbeam Cape", priority=1},
		left_ring="Chirich Ring +1",
		right_ring="Shneddick Ring +1",
		left_ear={ name="Alabaster Earring", priority=1},
		right_ear="Infused Earring",
	}

    sets.precast.FC = {
    	ammo="Sapience Orb", --2
    	head="Carmine Mask +1", --14
		body={ name="Rev. Surcoat +4", priority=1}, --10
		hands="Leyline Gloves",
    	legs="Enif Cosciales", --8
    	feet="Chev. Sabatons +3", --13
    	neck={ name="Unmoving Collar +1", priority=1},
    	waist={ name="Plat. Mog. Belt", priority=1},
		left_ear={ name="Etiolation Earring", priority=1}, --1
		right_ear="Loquacious Earring", --2
		left_ring="Kishar Ring", --4
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}}, --10
	}

    sets.Enmity = { --150 Enmity Set w/Burtgang
    	ammo="Sapience Orb", --2
    	head={ name="Loess Barbuta +1", augments={'Path: A',}, priority=1}, --24
    	body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=1}, --20
    	hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=1}, --9
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=1}, --9
    	feet="Chev. Sabatons +3", --15
    	neck={ name="Unmoving Collar +1", priority=1}, --10
    	waist="Creed Baudrier", --5
		left_ear="Cryptic Earring", --4
		right_ear="Trux Earring", --5
    	left_ring="Eihwaz Ring", --5
		right_ring="Apeile Ring +1", --9
    	back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Enmity+10','Phys. dmg. taken-10%',}}, --10/10
	}

	sets.precast.JA['Palisade'] = sets.Enmity
	sets.precast.JA['Shield Bash'] = sets.Enmity
	sets.precast.JA['Rampart'] = sets.Enmity
	sets.precast.JA['Sentinel'] = set_combine(sets.Enmity, {feet={ name="Cab. Leggings +3", augments={'Enhances "Guardian" effect',}},})
	sets.precast.JA['Divine Emblem'] = {feet="Chev. Sabatons +3"}
	sets.precast.JA['Holy Circle'] = {feet="Rev. Leggings +4"}
	sets.precast.JA['Chivalry'] = {"Cab. Gauntlets +3", augments={'Enhances "Chivalry" effect',}}
	sets.precast.JA['Majesty'] = {}

	sets.midcast['Jettatura'] = sets.Enmity
	sets.midcast['Blank Gaze'] = sets.Enmity

	sets.midcast['Flash'] = sets.Enmity

    sets.SIRD = { -- 105% SIRD (with merits), 56% DT (4 from set bonus), +101 Enmity (w/ Burtgang)
    	ammo="Staunch Tathlum +1", --11% --3dt
    	head={ name="Loess Barbuta +1", augments={'Path: A',}}, --24e --20dt
    	body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, --20e --10dt --11C
    	hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=1}, --9e
    	legs="Founder's Hose", --30%
    	feet="Odyssean Greaves", --20% --7C --6e
    	neck="Moonlight Necklace", --15% --15e
    	waist="Audumbla Sash", --10% --4pdt
		left_ear="Knightly Earring",--9%
		right_ear="Chev. Earring +1",
    	left_ring="Murky Ring",
    	right_ring="Defending Ring",
		back={ name="Moonbeam Cape", priority=1}, --5dt
	}

	sets.midcast['Blue Magic'] = sets.SIRD
	sets.midcast['Banishga'] = sets.SIRD
	sets.midcast['Diaga'] = sets.SIRD
	sets.midcast['Protect V'] = { sub="Srivatsa"}

	sets.midcast['Reprisal'] = {
		ammo="Staunch Tathlum +1", --11
		head="Carmine Mask +1",
		body={ name="Adamantite Armor", priority=1},
		hands={ name="Regal Gauntlets", priority=1}, --10
		legs="Founder's Hose", --30
    	feet="Chev. Sabatons +3",
		neck="Moonlight Necklace", --15
		waist={ name="Plat. Mog. Belt", priority=1},
		left_ear="Knightly Earring", --9
		right_ear="Magnetic Earring", --8
		left_ring="Murky Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}}, --10
	}

	--Cure (tier I) capped at 50% + Majesty (Cure tier II) is 25% + Cure Potency effect capped at 30%; = Total from all sources cap 95%

	sets.midcast['Healing Magic'] = set_combine(sets.SIRD, { -- 103% SIRD (with merits), 54% DT (4 from set bonus), Set is capped Cure
		waist="Sroda Belt", --35C
		right_ear="Magnetic Earring", --8%
		left_ring="Moonlight Ring",
	})

	--Notable Phalanx Tiers
	--Skill:	300	329	358	386	415	443	472	500
	----Dmg:	-28	-29	-30	-31	-32	-33	-34	-35

	sets.midcast['Phalanx'] = {
		main="Sakpata's Sword", --5
		sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}}, --2
    	ammo="Staunch Tathlum +1",
    	head="Valorous Mask", --4
    	body="Valorous Mail", --4
		--hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, --5
    	hands="Regal Gauntlets",
    	legs={ name="Sakpata's Cuisses", augments={'Path: A',}}, --5
    	feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, --5
    	neck="Warder's Charm +1",
    	waist={ name="Plat. Mog. Belt", priority=1},
		left_ear="Alabaster Earring",
    	right_ear="Chev. Earring +1",
		left_ring={ name="Moonlight Ring", priority=1},
		right_ring="Defending Ring",
    	back="Weard Mantle", --4
	}

    sets.precast.WS = sets.Enmity

    sets.precast.WS['Atonement'] = set_combine(sets.Enmity, {
    	neck="Fotia Gorget",
    	waist="Fotia Belt",
	})

    sets.precast.WS['Aeolian Edge'] = {
    	ammo="Oshasha's Treatise",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Baetyl Pendant",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
    	right_ear="Moonshade Earring",
		left_ring="Cornelia's Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
	}

end