-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    res = require 'resources'
end

-- Setup vars that are user-independent.
function job_setup()

    rayke_duration = 35
    gambit_duration = 96

    lockstyleset = 121

end

function user_setup()
select_default_macro_book()
set_lockstyle()
lockstyleset = 122
end


------------------------------------------------------------------------------------------------------
-- Checks Which Set To Use When Buffed/Debuffed. --
------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)

    local name = buff:lower()

    if state.Buff[buff] then
        state.Buff[buff] = gain
    end

    if not midaction() then
        handle_equipping_gear(player.status)
    end

	if buff == "sleep" then
		if gain then
			equip({main="Prime Blade"})
			add_to_chat(122, 'Slept equip Prime Blade.')
		else
			handle_equipping_gear(player.status)
		end
	end
	
end


function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.JA['Vallation'] = set_combine(sets.Enmity, {
        body="Runeist Coat +4",
        legs="Futhark Trousers +3",
        back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}},
        })

    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']

    sets.precast.JA['Pflug'] = {feet="Runeist Bottes +1"}
    sets.precast.JA['Battuta'] = {head="Fu. Bandeau +3"}
    sets.precast.JA['Liement'] = {body="Futhark Coat +3"}

    sets.precast.JA['Gambit'] = {hands="Rune. Mitons +4", back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}},}
    sets.precast.JA['Rayke'] = {feet="Futhark Boots +3", back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}},}

    sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat +3"}
    sets.precast.JA['Swordplay'] = {hands="Futhark Mitons +3"}

    sets.precast.JA['Vivacious Pulse'] = {
        ammo={name="Sapience Orb", priority=1},
        head={name="Rune. Bandeau +2", priority=3},
        body="Runeist Coat +4",
        legs="Rune. Trousers +1",
        feet={name="Turms Leggings +1", priority=2},
        ear1={name="Tuisto Earring", priority=4},
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}},
        }

    sets.precast.JA['Vivacious Pulse'].Status = {head="Erilaz Galea +3",}

    -- Fast cast sets for spells FC 61
    sets.precast.FC = {
		ammo="Sapience Orb",
		head="Rune. Bandeau +2",
		body="Erilaz Surcoat +3",
		hands="Agwu's Gages",
		legs="Agwu's Slops",
		feet="Agwu's Pigaches",
		neck="Baetyl Pendant",
		waist="Plat. Mog. Belt",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Kishar Ring",
		right_ring="Defending Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}},
    }
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        legs="Futhark Trousers +3",
        })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC


	sets.midcast['Flash'] = {
			ammo={name="Sapience Orb", priority=1}, --2
			head="Halitus Helm", --8
			body="Emet Harness +1", --10
			hands="Kurys Gloves", --9
			legs="Eri. Leg Guards +3", --11
			feet="Erilaz Greaves +3",--8
			neck={name="Unmoving Collar +1", priority=4}, --10
			ear1={name="Tuisto Earring", priority=3},
			ear2="Trux Earring",
			ring1={name="Petrov Ring", priority=2}, --5
			ring2="Eihwaz Ring", --5
			back={ name="Ogma's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},
			waist="Warwolf Belt", --3
		}

    sets.midcast['Enhancing Magic'] = {
        head="Erilaz Galea +3",
        hands="Regal Gauntlets",
        legs="Futhark Trousers +3",
        }

    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
        head="Fu. Bandeau +3", --7
        })

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {head="Rune. Bandeau +2"})
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Erilaz Galea +3"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'])
    sets.midcast.Shell = sets.midcast.Protect

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------
		sets.idle = { --54% PDT (52+2 from Strap)
        main="Epeolatry",
        sub="Alber Strap", --2
        ammo="Eluder's Sachet", --5 ECD +2 DT
        head="Null Masque", --10
        body="Runeist Coat +4",
        hands="Nyame Gauntlets", --7
        legs="Nyame Flanchard", --8
        feet="Nyame Sollerets", --7
        neck="Elite Royal Collar", --5
        waist={ name="Plat. Mog. Belt", priority=1}, --3
        left_ear={ name="Alabaster Earring", augments={'Path: A',}}, --5 DT
        right_ear="Erilaz Earring +1", --5 DT
        left_ring="Fortified Ring", --7 ECD and MDT 5
        right_ring="Shneddick Ring",
        back={ name="Ogma's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},
        }
 
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

	sets.engaged = { --52% DT/(75% PDT), focus on parrying and physical dmg
        main="Epeolatry",
        sub="Alber Strap", --2
        ammo="Eluder's Sachet", --5 ECD +2 DT
        head={ name="Nyame Helm", augments={'Path: B',}}, --7 DT
        body="Adamantite Armor", --20
        hands="Turms Mittens +1", --Parry
        legs="Eri. Leg Guards +3", --13 and Parry
        feet="Turms Leggings +1", --Parry
        neck="Elite Royal Collar", --5
        waist="Carrier's Sash",
        left_ear={ name="Alabaster Earring", augments={'Path: A',},priority=1}, --5 DT
        right_ear={ name="Odnowa Earring +1", augments={'Path: A',},priority=1}, --3 DT and 2 MDT
        left_ring="Fortified Ring", --7 ECD and MDT 5
        right_ring={ name="Moonlight Ring", priority=1}, --5
        back={ name="Ogma's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},
    }

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_aftercast(spell, action, spellMap, eventArgs)

    if spell.name == 'Rayke' and not spell.interrupted then
        send_command('@timers c "Rayke ['..spell.target.name..']" '..rayke_duration..' down spells/00136.png')
        send_command('wait '..rayke_duration..';input /echo [Rayke just wore off!];')
    elseif spell.name == 'Gambit' and not spell.interrupted then
        send_command('@timers c "Gambit ['..spell.target.name..']" '..gambit_duration..' down spells/00136.png')
        send_command('wait '..gambit_duration..';input /echo [Gambit just wore off!];')
    end
end



function select_default_macro_book()
    set_macro_page(1, 22)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end