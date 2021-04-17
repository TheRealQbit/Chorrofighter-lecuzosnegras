local function pylon(number, tp, x, y, z, params, wcs)
	local res = params;
	
	res.Number = number;
	res.Type = tp;
	res.X = x;
	res.Y = y;
	res.Z = z;
	res.Launchers = wcs or {};
	
	res.Launchers[#res.Launchers + 1] = { CLSID = "{6CEB49FC-DED8-4DED-B053-E1F033FF72D3}", arg_increment = -0.1} --AIM-9M
	res.Launchers[#res.Launchers + 1] = { CLSID = "{9BFD8C90-F7AE-4e90-833B-BFD0CED0E536}", arg_increment = -0.1} --AIM-9P
	res.Launchers[#res.Launchers + 1] = { CLSID = "{AIM-9P5}"							  , arg_increment = -0.1} --AIM-9P5
	res.Launchers[#res.Launchers + 1] = { CLSID = "{AIM-9L}"							  , arg_increment = -0.1} --AIM-9L

	return res;
end


Eurofighter =  {
      
		Name 			=  	 'Eurofighter',
		DisplayName		= _('Eurofighter'),
        Picture 		= "Eurofighter.png",
        Rate 			= "50",
        Shape			= "eurofighter",		
		WorldID			=  WSTYPE_PLACEHOLDER, 
		Cannon = "yes",
		-- HumanCockpit 		= true,
		-- HumanCockpitPath    = current_mod_path..'/Cockpit/Scripts/',
        
	shape_table_data 	= 
	{
		{
			file  	 	= 'Eurofighter';--AG
			life  	 	= 20; -- lifebar
			vis   	 	= 3; -- visibility gain.
			desrt    	= 'Eurofighter-oblomok'; -- Name of destroyed object file name
			fire  	 	= { 300, 2}; -- Fire on the ground after destoyed: 300sec 2m
			username	= 'Eurofighter';--AG
			index       =  WSTYPE_PLACEHOLDER;
			classname   = "lLandPlane";
			positioning = "BYNORMAL";
		},
		{
			name  		= "Eurofighter-oblomok";
			file  		= "Eurofighter-oblomok";
			fire  		= { 240, 2};
		},
	},

	net_animation ={
        0, -- front gear
        3, -- right gear
        5, -- left gear
        9, -- right flap
        10, -- left flap
        11, -- right aileron
        12, -- left aileron
        15, -- right elevator
        16, -- left elevator
        17, -- rudder

        2,  -- nose wheel steering
        21, -- SFM air brake
        13, -- right slat
        14, -- left slat
        25, -- tail hook
        38, -- canopy
        120, -- right spoiler
        123, -- left spoiler
        190, -- left (red) navigation wing-tip light
        191, -- right (green) navigation wing-tip light
        192, -- tail (white) light

        198, -- anticollision (flashing red) top light
        199, -- anticollision (flashing red) bottom light
        208, -- taxi light (white) right main gear door
        402, -- huffer
        500, -- model air brake
        501, -- RAT
        499, -- wheel chocks
		117, -- stabilizer

    },
	
	LandRWCategories = 
        {
        [1] = 
        {
			Name = "AircraftCarrier",
        },
        [2] = 
        {
            Name = "AircraftCarrier With Catapult",
        }, 
        [3] = 
        {
            Name = "AircraftCarrier With Tramplin",
        }, 
    }, -- end of LandRWCategories
        TakeOffRWCategories = 
        {
        [1] = 
        {
			Name = "AircraftCarrier",
        },
        [2] = 
        {
            Name = "AircraftCarrier With Catapult",
        }, 
        [3] = 
        {
            Name = "AircraftCarrier With Tramplin",
        }, 
    }, -- end of TakeOffRWCategories
	
	mapclasskey 		= "P0091000024",
	attribute  			= {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER, "Fighters", "Refuelable",},--AG
	Categories= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},
	
		M_empty						=	13380,	-- kg  with pilot and nose load, F15
		M_nominal					=	19000,	-- kg (Empty Plus Full Internal Fuel)
		M_max						=	30845,	-- kg (Maximum Take Off Weight)
		M_fuel_max					=	6103,	-- kg (Internal Fuel Only)
		H_max						=	18300,	-- m  (Maximum Operational Ceiling)
		average_fuel_consumption	=	0.271,
		CAS_min						=	58,		-- Minimum CAS speed (m/s) (for AI)
		V_opt						=	220,	-- Cruise speed (m/s) (for AI)
		V_take_off					=	61,		-- Take off speed in m/s (for AI)
		V_land						=	71,		-- Land speed in m/s (for AI)
		has_afteburner				=	true,
		has_speedbrake				=	true,
		radar_can_see_ground		=	true,

		nose_gear_pos 				                = {4.59,	-2.150,	0},   -- nosegear coord 
	    nose_gear_amortizer_direct_stroke   		=  0,      -- down from nose_gear_pos !!!
	    nose_gear_amortizer_reversal_stroke  		=  -0.43,  -- up 
	    nose_gear_amortizer_normal_weight_stroke 	=  -0.215,   -- up 
	    nose_gear_wheel_diameter 	                =  0.754,  -- in m
	
	    main_gear_pos 						 	    = {-0.8,	-2.000,	1.425}, -- main gear coords 
	    main_gear_amortizer_direct_stroke	 	    =   0,     --  down from main_gear_pos !!!
	    main_gear_amortizer_reversal_stroke  	    =   -0.228, --  up 
	    main_gear_amortizer_normal_weight_stroke    =   -0.114,-- down from main_gear_pos
	    main_gear_wheel_diameter 				    =   0.972, --  in m

		AOA_take_off				=	0.16,	-- AoA in take off (for AI)
		stores_number				=	12,
		bank_angle_max				=	60,		-- Max bank angle (for AI)
		Ny_min						=	-3,		-- Min G (for AI)
		Ny_max						=	8,		-- Max G (for AI)
		V_max_sea_level				=	540,	-- Max speed at sea level in m/s (for AI)
		V_max_h						=	736.11,	-- Max speed at max altitude in m/s (for AI)
		wing_area					=	56.5,	-- wing area in m2
		thrust_sum_max				=	18347,	-- thrust in kgf (60.0 kN)
		thrust_sum_ab				=	27952,	-- thrust in kgf (90.0 kN)
		Vy_max						=	275,	-- Max climb speed in m/s (for AI)
		flaps_maneuver				=	1,
		Mach_max					=	2.5,	-- Max speed in Mach (for AI)
		range						=	2540,	-- Max range in km (for AI)
		RCS							=	3,		-- Radar Cross Section m2
		Ny_max_e					=	8,		-- Max G (for AI)
		detection_range_max			=	250,
		IR_emission_coeff			=	0.91,	-- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
		IR_emission_coeff_ab		=	4,		-- With afterburner
		tand_gear_max				=	3.73,--XX  1.732 FA18 3.73, 
		tanker_type					=	2,-- F14=2/S33=4/M29=0/S27=0/F15=1/F16=1/To=0/F18=2/A10A=1/M29K=4/M2000=2/F4=0/F5=0/
		wing_span					=	13.05,
		wing_type 					= 	0,-- FIXED_WING = 0/VARIABLE_GEOMETRY = 1/FOLDED_WING = 2/ARIABLE_GEOMETRY_FOLDED = 3
		length						=	19.43,
		height						=	5.63,
		crew_size					=	1,
		engines_count				=	2,
		wing_tip_pos 				= 	{-4.466,	0.0,	5.707},
		engines_nozzles = 
		{
			[1] = 
			{
				pos = 	{-6.051,	-0.277,	-0.555},---6.051,	-0.347,	-0.705
				elevation	=	-1.0,
				diameter	=	1.076,
				exhaust_length_ab	= 5.8,
				exhaust_length_ab_K	= 0.76,
				smokiness_level     = 	0.01, 
			}, -- end of [1]
			[2] = 
			{
				pos = 	{-6.051,	-0.277,	0.555},
				elevation	=	-1.0,
				diameter	=	1.076,
				exhaust_length_ab	= 5.8,
				exhaust_length_ab_K	= 0.76,
				smokiness_level     = 	0.01, 
			}, -- end of [2]
		}, -- end of engines_nozzles
		crew_members = 
		{
			[1] = 
			{
				ejection_seat_name	=	17,
				pilot_name			= 	19,
				drop_canopy_name	=	"vsn_eurofighter_fonar";
				pos = 	{4.750,	1.42,	0},
			}, -- end of [1]
		}, -- end of crew_members
		brakeshute_name	=	0,
		is_tanker	=	false,
		air_refuel_receptacle_pos = 	{8.35,	1.37,	1.42},--{1.512,	0.805,	0},
		fires_pos = 
		{
			[1] = 	{-1.842,	0.563,	0},
			[2] = 	{-1.644,	0.481,	2.87},
			[3] = 	{-1.389,	0.461,	-3.232},
			[4] = 	{-0.82,	0.265,	2.774},
			[5] = 	{-0.82,	0.265,	-2.774},
			[6] = 	{-0.82,	0.255,	4.274},
			[7] = 	{-0.82,	0.255,	-4.274},
			[8] = 	{-5.753,	0.06,	0.705},
			[9] = 	{-5.753,	0.06,	-0.705},
			[10] = 	{-0.992,	0.85,	0},
			[11] = 	{-1.683,	0.507,	-2.91},
		}, -- end of fires_pos
		
		effects_presets = {
			{effect = "OVERWING_VAPOR", file = current_mod_path.."/Effects/VSN_EF_overwingVapor.lua"},
		},
		
		chaff_flare_dispenser = 
		{
			[1] = 
			{
				dir = 	{0,	-1,	0},
				pos = 	{-1.185,	-1.728,	-0.878},
			}, -- end of [1]
			[2] = 
			{
				dir = 	{0,	-1,	0},
				pos = 	{-1.185,	-1.728,	0.878},
			}, -- end of [2]
		}, -- end of chaff_flare_dispenser

        -- Countermeasures
passivCounterm 		= {
CMDS_Edit 			= true,
SingleChargeTotal 	= 240,
chaff 				= {default = 120, increment = 30, chargeSz = 1},
flare 				= {default = 60, increment = 30, chargeSz = 2}
 },
	
        CanopyGeometry 	= {
            azimuth 	= {-145.0, 145.0},-- pilot view horizontal (AI)
            elevation 	= {-50.0, 90.0}-- pilot view vertical (AI)
        },

Sensors = {
RADAR 			= "AN/APG-63",--F15
RWR 			= "Abstract RWR"--F15
},
Countermeasures = {
ECM 			= "AN/ALQ-135"--F15
},
	Failures = {
			{ id = 'asc', 		label = _('ASC'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'autopilot', label = _('AUTOPILOT'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'hydro',  	label = _('HYDRO'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'l_engine',  label = _('L-ENGINE'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'r_engine',  label = _('R-ENGINE'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'radar',  	label = _('RADAR'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--			{ id = 'eos',  		label = _('EOS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
--			{ id = 'helmet',  	label = _('HELMET'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'mlws',  	label = _('MLWS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'rws',  		label = _('RWS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'ecm',   	label = _('ECM'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'hud',  		label = _('HUD'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'mfd',  		label = _('MFD'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
	},
	HumanRadio = {
		frequency 		= 127.5,  -- Radio Freq
		editable 		= true,
		minFrequency	= 100.000,
		maxFrequency 	= 156.000,
		modulation 		= MODULATION_AM
	},

Guns = {gun_mount("M_61", { count = 480 },{muzzle_pos = {0.611000, -0.790000, 0.373000}})
},

pylons_enumeration = {1, 11, 10, 2, 3, 9, 4, 5, 7, 8, 6},

	Pylons =	{
		pylon(1, 0, -2.15, 0.395, -6.405,
			{
				use_full_connector_position = true,
				connector 	  = "Pylon1",
				DisplayName   = "1",
				arg 	  	  = 308,
				arg_increment = 0.0,
			},
			{
				{ CLSID = "{irist}" },
				{ CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}" }, --AIM-9X
				{ CLSID = "{AIM-9L}" },	
				{CLSID = "{INV-SMOKE-RED}"},		--Smoke Generator - red
				{CLSID = "{INV-SMOKE-GREEN}"},		--Smoke Generator - green
				{CLSID = "{INV-SMOKE-BLUE}"},		--Smoke Generator - blue
				{CLSID = "{INV-SMOKE-WHITE}"},		--Smoke Generator - white
				{CLSID = "{INV-SMOKE-YELLOW}"},	--Smoke Generator - yellow
				{CLSID = "{INV-SMOKE-ORANGE}"},	--Smoke Generator - orange				
				{ CLSID = "{AIS_ASQ_T50}" ,arg_increment = -0.1, attach_point_position = {0.30,  0.0,  0.0}},			-- ACMI pod
				{ CLSID = "<CLEAN>"									,arg_increment = 1},
			}
		),
		pylon(2, 0, -1.87, 0.075, -4.27,
			{
				use_full_connector_position = true,
				connector 	  = "Pylon3",
				DisplayName   = "2",
				arg 	  	  = 310,
				arg_increment = 0.0,
			},
			{
				{ CLSID = "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}" }, -- GBU-10	
				{ CLSID = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}" }, -- GBU-16	
				{ CLSID = "{34759BBC-AF1E-4AEE-A581-498FF7A6EBCE}" }, -- GBU-24
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },   -- MK-82
				{ CLSID = "{GBU-31}" }, -- GBU-38 JDAM
				{ CLSID = "{LAU3_FFAR_MK5HEAT}" }, -- COHETES  HYDRA 70
				{ CLSID = "{BRU-42_3*Mk-83}" }, -- MK- 83
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" }, -- MK- 82 X3
				{ CLSID = "{BRU-42_3*Mk-82SNAKEYE}" }, -- MK-82 SNAKEAYE X3
				{ CLSID = "{BRU-42_3*Mk-82AIR}" }, -- MK-82 AIR X3
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{CBU-87}" }, -- CBU-87
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" }, --AIM-120C
				{ CLSID = "{irist}" },
				{ CLSID = "{aim132}" },
				{ CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}" }, --AIM-9X
				{ CLSID = "{brimstone}" },
				{ CLSID = "{Meteor}" },
				{ CLSID = "<CLEAN>"									,arg_increment = 1},
			}
		),
		pylon(3, 0, -1.02, -0.074, -3.325,
			{
				use_full_connector_position = true,
				connector 	  = "Pylon2",
				DisplayName   = "3",
				arg 	  	  = 309,
				arg_increment = 0.0,
			},
			{
				{ CLSID = "{VSN_EFT_PTB}" ,arg_increment = 0.0,Cx_gain = 1/2.2},
				{ CLSID = "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}" }, -- GBU-10	
				{ CLSID = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}" }, -- GBU-16	
				{ CLSID = "{34759BBC-AF1E-4AEE-A581-498FF7A6EBCE}" }, -- GBU-24
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },   -- MK-82
				{ CLSID = "{GBU-31}" }, -- GBU-38 JDAM
				{ CLSID = "{LAU3_FFAR_MK5HEAT}" }, -- COHETES  HYDRA 70
				{ CLSID = "{BRU-42_3*Mk-83}" }, -- MK- 83
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" }, -- MK- 82 X3
				{ CLSID = "{BRU-42_3*Mk-82SNAKEYE}" }, -- MK-82 SNAKEAYE X3
				{ CLSID = "{BRU-42_3*Mk-82AIR}" }, -- MK-82 AIR X3
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{CBU-87}" }, -- CBU-87
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" }, --AIM-120C
				{ CLSID = "{irist}" },	
				{ CLSID = "{aim132}" },
				{ CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}" }, --AIM-9X
				{ CLSID = "{brimstone}" },	
				{ CLSID = "{Meteor}" },
				{ CLSID = "<CLEAN>"									,arg_increment = 1},
			}
		),
		pylon(4, 1, -0.77, -0.066, -2.297,
			{
				use_full_connector_position = true,
				connector 	  = "Pylon4",-- Doppelfunktion  Arg.0.0 und Arg. 0.80 f�r Bomben
				DisplayName   = "4",
				arg 	  	  = 311,
				arg_increment = 1,
			},
			{
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" ,arg_increment = 0.6}, -- AIM-120C
				{ CLSID = "{AGM_84}" ,arg_increment = 0.6},								  -- AGM-88	
				{ CLSID = "{Meteor}" ,arg_increment = 0.6},
				{ CLSID = "{aim132}" ,arg_increment = 0.6},
			}
		),
		pylon(5, 1, -2.47, -0.45, -1.165,--2.47, -0.5, -1.215
			{
				use_full_connector_position = true,
				connector 	  = "Pylon5",
				DisplayName   = "5",
			},
			{
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" }, -- AIM-120C
				{ CLSID = "{AGM_84}" },								  -- AGM-88	
				{ CLSID = "{Meteor}" },
				{ CLSID = "{aim132}" },
			}
		),
		pylon(6, 1,  0.93, -0.466, 0,
			{
				use_full_connector_position = true,
				connector 	  = "Pylon6",
				DisplayName   = "6",
				arg 	  	  = 313,
				arg_value     = 0.0,
			},
			{
				{ CLSID = "{VSN_EFT_PTB}" ,arg_increment = 0.0,Cx_gain = 1/2.2},
				{ CLSID = "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}" }, -- GBU-10	
				{ CLSID = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}" }, -- GBU-16	
				{ CLSID = "{34759BBC-AF1E-4AEE-A581-498FF7A6EBCE}" }, -- GBU-24
				{ CLSID = "{GBU-31}" }, -- GBU-38 JDAM
				{ CLSID = "{BRU-42_3*Mk-83}" }, -- MK- 83
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" }, -- MK- 82 X3
				{ CLSID = "{BRU-42_3*Mk-82SNAKEYE}" }, -- MK-82 SNAKEAYE X3
				{ CLSID = "{BRU-42_3*Mk-82AIR}" }, -- MK-82 AIR X3
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{CBU-87}" }, -- CBU-87
				{ CLSID = "{AAQ-28_LEFT}"},	--Litening	
				{ CLSID = "<CLEAN>"									,arg_increment = 1},
			}
		),
		pylon(7, 1, 2.47, -0.45, 1.165,--2.47, -0.5, 1.215
			{
				use_full_connector_position = true,
				connector 	  = "Pylon7",
				DisplayName   = "7",
			},
			{
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" }, -- AIM-120C
				{ CLSID = "{AGM_84}" },								  -- AGM-88	
				{ CLSID = "{Meteor}" },
				{ CLSID = "{aim132}" },
			}
		),
		pylon(8, 1,  -0.77, -0.066, 2.297,
			{
				use_full_connector_position = true,
				connector 	  = "Pylon8",-- Doppelfunktion  Arg.0.0 und Arg. 0.80 f�r Bomben
				DisplayName   = "8",
				arg 	  	  = 315,
				arg_increment = 1,
			},
			{
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" ,arg_increment = 0.6}, -- AIM-120C
				{ CLSID = "{AGM_84}" ,arg_increment = 0.6},								  -- AGM-88	
				{ CLSID = "{Meteor}" ,arg_increment = 0.6},
				{ CLSID = "{aim132}" ,arg_increment = 0.6},
			}
		),
		pylon(9, 0, -1.02, -0.074, 3.325, 
			{
				use_full_connector_position = true,
				connector 	  = "Pylon10",
				DisplayName   = "9",
				arg 	      = 317,
				arg_increment = 0.0,
			},
			{
				{ CLSID = "{VSN_EFT_PTB}" ,arg_increment = 0.0,Cx_gain = 1/2.2},
				{ CLSID = "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}" }, -- GBU-10	
				{ CLSID = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}" }, -- GBU-16	
				{ CLSID = "{34759BBC-AF1E-4AEE-A581-498FF7A6EBCE}" }, -- GBU-24
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },   -- MK-82
				{ CLSID = "{GBU-31}" }, -- GBU-38 JDAM
				{ CLSID = "{LAU3_FFAR_MK5HEAT}" }, -- COHETES  HYDRA 70
				{ CLSID = "{BRU-42_3*Mk-83}" }, -- MK- 83
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" }, -- MK- 82 X3
				{ CLSID = "{BRU-42_3*Mk-82SNAKEYE}" }, -- MK-82 SNAKEAYE X3
				{ CLSID = "{BRU-42_3*Mk-82AIR}" }, -- MK-82 AIR X3
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{CBU-87}" }, -- CBU-87
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" }, --AIM-120C
				{ CLSID = "{irist}" },	
				{ CLSID = "{aim132}" },
				{ CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}" }, --AIM-9X
				{ CLSID = "{brimstone}" },	
				{ CLSID = "{Meteor}" },
				{ CLSID = "<CLEAN>"									,arg_increment = 1},
			}
		),
		pylon(10, 0, -1.87, 0.075, 4.27,
			{
				use_full_connector_position = true,
				connector 	  = "Pylon9",
				DisplayName   = "10",
				arg 	      = 316,
				arg_increment = 0.0,
			},
			{
				{ CLSID = "{51F9AAE5-964F-4D21-83FB-502E3BFE5F8A}" }, -- GBU-10	
				{ CLSID = "{0D33DDAE-524F-4A4E-B5B8-621754FE3ADE}" }, -- GBU-16	
				{ CLSID = "{34759BBC-AF1E-4AEE-A581-498FF7A6EBCE}" }, -- GBU-24
				{ CLSID = "{BCE4E030-38E9-423E-98ED-24BE3DA87C32}" },   -- MK-82
				{ CLSID = "{GBU-31}" }, -- GBU-38 JDAM
				{ CLSID = "{LAU3_FFAR_MK5HEAT}" }, -- COHETES  HYDRA 70
				{ CLSID = "{BRU-42_3*Mk-83}" }, -- MK- 83
				{ CLSID = "{60CC734F-0AFA-4E2E-82B8-93B941AB11CF}" }, -- MK- 82 X3
				{ CLSID = "{BRU-42_3*Mk-82SNAKEYE}" }, -- MK-82 SNAKEAYE X3
				{ CLSID = "{BRU-42_3*Mk-82AIR}" }, -- MK-82 AIR X3
				{ CLSID = "{5335D97A-35A5-4643-9D9B-026C75961E52}" }, -- CBU-97
				{ CLSID = "{CBU-87}" }, -- CBU-87
				{ CLSID = "{40EF17B7-F508-45de-8566-6FFECC0C1AB8}" }, --AIM-120C
				{ CLSID = "{irist}" },
				{ CLSID = "{aim132}" },
				{ CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}" }, --AIM-9X
				{ CLSID = "{brimstone}" },
				{ CLSID = "{Meteor}" },
				{ CLSID = "<CLEAN>"									,arg_increment = 1},
			}
		),
		pylon(11, 0, -2.15, 0.395, 6.405,--2.15, 0.475, 6.455
			{
				use_full_connector_position = true,
				connector 	  = "Pylon11",
				DisplayName   = "11",
				arg 	 	  = 318,
				arg_increment = 0.0,
			},
			{
				{ CLSID = "{irist}" },
				{ CLSID = "{5CE2FF2A-645A-4197-B48D-8720AC69394F}" }, --AIM-9X
				{ CLSID = "{AIM-9L}" },	
				{CLSID = "{INV-SMOKE-RED}"},		--Smoke Generator - red
				{CLSID = "{INV-SMOKE-GREEN}"},		--Smoke Generator - green
				{CLSID = "{INV-SMOKE-BLUE}"},		--Smoke Generator - blue
				{CLSID = "{INV-SMOKE-WHITE}"},		--Smoke Generator - white
				{CLSID = "{INV-SMOKE-YELLOW}"},	--Smoke Generator - yellow
				{CLSID = "{INV-SMOKE-ORANGE}"},	--Smoke Generator - orange
				{ CLSID = "<CLEAN>"									,arg_increment = 1},
			
			}
		),
},


	Tasks = {
        aircraft_task(CAP),
     	aircraft_task(Escort),
      	aircraft_task(FighterSweep),
		aircraft_task(Intercept),
		aircraft_task(Reconnaissance),
    	aircraft_task(GroundAttack),
     	aircraft_task(CAS),
        aircraft_task(AFAC),
	    aircraft_task(RunwayAttack),
--    	aircraft_task(AntishipStrike),
    },	
	DefaultTask = aircraft_task(CAP),
	SFM_Data = {
		aerodynamics = --F15
			{
				Cy0	=	0,
				Mzalfa	=	6,
				Mzalfadt	=	1,
				kjx = 2.95,
				kjz = 0.00125,
				Czbe = -0.001,
				cx_gear = 0.005,
				cx_flap = 0.05,
				cy_flap = 0.18,
				cx_brk = 0.08,
				table_data = 
				{
				--      M	 Cx0		 Cya		 B		 	B4	    Omxmax	Aldop	Cymax
					{0.0,	0.0144,		0.055,		0.177,		0.22,	0.5,	30.0,	1.2 	}, --30
					{0.2,	0.0144,		0.055,		0.177,		0.22,	2.80,	30.0,	1.2     },
					{0.4,	0.0144,		0.055,		0.177,	   	0.22,	3.20,	30.0,	1.2     },
					{0.6,	0.0154,		0.055,		0.177,		0.28,	4.85,	30.0,	1.2     },
					{0.7,	0.0467,		0.055,		0.156,		0.28,	4.83,	28.667,	1.15    }, --28.67
					{0.8,	0.0582,		0.055,		0.150,		0.28,	4.80,	27.333,	1.1     }, --27.33
					{0.9,	0.0621,		0.058,		0.146,		0.20,	4.75,	26.0,	1.07    }, --26
					{1.0,	0.0634,		0.062,		0.142,		0.15,	4.726,	24.667,	1.04    }, --24
					{1.1,	0.0643,		0.062,	   	0.1407,		0.09,	4.701,	18.0,	1.02    }, --1
					{1.2,	0.0642,		0.062,	   	0.141,		0.08,	4.675,	17.0,	1.00 	},		
					{1.3,	0.0641,		0.06,	   	0.141,		0.10,	6.65,	16.0,	0.92 	},				
					{1.4,	0.0635,		0.056,	   	0.143,		0.136,	4.58,	15.0,	0.80 	},					
					{1.6,	0.0620,		0.052,	   	0.150,		0.21,	4.547,	13.0,	0.7 	},					
					{1.8,	0.0606,		0.042,	   	0.157,		2.43,	4.47,	12.0,	0.55 	},		
					{2.2,	0.0553,		0.037,	   	0.164,		3.5,	4.419,	 10.0,	0.4 	},					
					{2.5,	0.0531,		0.033,		0.175,		4.7,	3.5,	 9.0,	0.4 	},		
				}, -- end of table_data
			}, -- end of aerodynamics
		engine = 
		{
			Nmg	=	67.5,
			MinRUD	=	0,
			MaxRUD	=	1,
			MaksRUD	=	0.85,
			ForsRUD	=	0.91,
			type	=	"TurboJet",
			hMaxEng	=	19.5,
			dcx_eng	=	0.0114,
			cemax	=	1.24,
			cefor	=	2.56,
			dpdh_m	=	1650,
			dpdh_f	=	14000.0,
			table_data = {
			--   M		Pmax		 Pfor
				{0.0,	138000,		282000},
				{0.2,	138000,		270000},
				{0.4,	149000,		275000},
				{0.6,	154000,		277000},
				{0.7,	161000,		280000},
				{0.8,	161000,		290000},
				{0.9,	184000,		315000},
				{1.0,	193000,		320000},
				{1.1,	193000,		328000},
				{1.2,	184000,		338000},
				{1.3,	174000,		355000},
				{1.4,	161000,		370000},
				{1.6,	154000,		388000},
				{1.8,	149000,		407000},
				{2.2,	142000,		440000},
				{2.5,	138000,		460000},
			}, -- end of table_data
		}, -- end of engine
	},


	--damage , index meaning see in  Scripts\Aircrafts\_Common\Damage.lua
	Damage = {
	[0]  = {critical_damage = 5,  args = {146}},
	[1]  = {critical_damage = 3,  args = {296}},
	[2]  = {critical_damage = 3,  args = {297}},
	[3]  = {critical_damage = 8, args = {65}},
	[4]  = {critical_damage = 2,  args = {298}},
	[5]  = {critical_damage = 2,  args = {301}},
	[7]  = {critical_damage = 2,  args = {249}},
	[8]  = {critical_damage = 3,  args = {265}},
	[9]  = {critical_damage = 3,  args = {154}},
	[10] = {critical_damage = 3,  args = {153}},
	[11] = {critical_damage = 1,  args = {167}},
	[12] = {critical_damage = 1,  args = {161}},
	[13] = {critical_damage = 2,  args = {169}},
	[14] = {critical_damage = 2,  args = {163}},
	[15] = {critical_damage = 2,  args = {267}},
	[16] = {critical_damage = 2,  args = {266}},
	[17] = {critical_damage = 2,  args = {168}},
	[18] = {critical_damage = 2,  args = {162}},
	[20] = {critical_damage = 2,  args = {183}},
	[23] = {critical_damage = 5, args = {223}},
	[24] = {critical_damage = 5, args = {213}},
	[25] = {critical_damage = 2,  args = {226}},
	[26] = {critical_damage = 2,  args = {216}},
	[29] = {critical_damage = 5, args = {224}, deps_cells = {23, 25}},
	[30] = {critical_damage = 5, args = {214}, deps_cells = {24, 26}},
	[35] = {critical_damage = 6, args = {225}, deps_cells = {23, 29, 25, 37}},
	[36] = {critical_damage = 6, args = {215}, deps_cells = {24, 30, 26, 38}}, 
	[37] = {critical_damage = 2,  args = {228}},
	[38] = {critical_damage = 2,  args = {218}},
	[39] = {critical_damage = 2,  args = {244}, deps_cells = {53}}, 
	[40] = {critical_damage = 2,  args = {241}, deps_cells = {54}}, 
	[43] = {critical_damage = 2,  args = {243}, deps_cells = {39, 53}},
	[44] = {critical_damage = 2,  args = {242}, deps_cells = {40, 54}}, 
	[51] = {critical_damage = 2,  args = {240}}, 
	[52] = {critical_damage = 2,  args = {238}},
	[53] = {critical_damage = 2,  args = {248}},
	[54] = {critical_damage = 2,  args = {247}},
	[56] = {critical_damage = 2,  args = {158}},
	[57] = {critical_damage = 2,  args = {157}},
	[59] = {critical_damage = 3,  args = {148}},
	[61] = {critical_damage = 2,  args = {147}},
	[82] = {critical_damage = 2,  args = {152}},
	},
	
	DamageParts = 
	{  
		[1] = "VSN_Eurofighter-oblomok-wing-r", -- wing R
		[2] = "VSN_Eurofighter-oblomok-wing-l", -- wing L
--		[3] = "VSN_Eurofighter-oblomok-noise", -- nose
--		[4] = "VSN_Eurofighter-oblomok-tail-r", -- tail
--		[5] = "VSN_Eurofighter-oblomok-tail-l", -- tail
	},
-- VSN DCS World\Scripts\Aircrafts\_Common\Lights.lua

	lights_data = { typename = "collection", lights = {
	
    [1] = { typename = "collection", -- WOLALIGHT_STROBES
					lights = {	
						--{typename  = "natostrobelight",	argument_1  = 199, period = 1.2, color = {0.8,0,0}, connector = "RESERV_BANO_1"},--R
						--{typename  = "natostrobelight",	argument_1  = 199, period = 1.2, color = {0.8,0,0}, connector = "RESERV1_BANO_1"},--L
						--{typename  = "natostrobelight",	argument_1  = 199, period = 1.2, color = {0.8,0,0}, connector = "RESERV2_BANO_1"},--H
						--{typename  = "natostrobelight",	argument_1  = 195, period = 1.2, color = {0.8,0,0}, connector = "WHITE_BEACON L"},--195
						--{typename  = "natostrobelight",	argument_1  = 196, period = 1.2, color = {0.8,0,0}, connector = "WHITE_BEACON R"},--196
						--{typename  = "natostrobelight",	argument_1  = 192, period = 1.2, color = {0.8,0,0}, connector = "BANO_0_BACK"},
						--{typename  = "natostrobelight",	argument_1  = 195, period = 1.2, color = {0.8,0,0}, connector = "RED_BEACON L"},
						--{typename  = "natostrobelight",	argument_1  = 196, period = 1.2, color = {0.8,0,0}, connector = "RED_BEACON R"},
						--{typename = "argnatostrobelight", argument = 195, period = 1.2, phase_shift = 0},-- beacon lights
						--{typename = "argnatostrobelight", argument = 196, period = 1.2, phase_shift = 0},-- beacon lights
							}
			},
	[2] = { typename = "collection",
					lights = {-- 1=Landing light -- 2=Landing/Taxi light
						{typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 209, dir_correction = {elevation = math.rad(-1)}},--"MAIN_SPOT_PTR_02","RESERV_SPOT_PTR"
						{typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 208, dir_correction = {elevation = math.rad(3)}},--"MAIN_SPOT_PTR_01","RESERV_SPOT_PTR","MAIN_SPOT_PTL",
							}
			},
    [3]	= {	typename = "collection", -- nav_lights_default
					lights = {
						{typename  = "omnilight",connector =  "BANO_1"  ,argument  =  190,color = {0.99, 0, 0}},-- Left Position(red)
						{typename  = "omnilight",connector =  "BANO_2"  ,argument  =  191,color = {0, 0.99, 0}},-- Right Position(green)
						{typename  = "omnilight",connector =  "BANO_0"  ,argument  =  192,color = {1, 1, 1}},-- Tail Position white)
							}
			},
	[4] = { typename = "collection", -- formation_lights_default
					lights = {
						{typename  = "argumentlight" ,argument  = 200,},--formation_lights_tail_1 = 200;
						{typename  = "argumentlight" ,argument  = 201,},--formation_lights_tail_2 = 201;
						{typename  = "argumentlight" ,argument  = 202,},--formation_lights_left   = 202;
						{typename  = "argumentlight" ,argument  = 203,},--formation_lights_right  = 203;
						{typename  = "argumentlight" ,argument  =  88,},--old aircraft arg 
						--{typename = "argnatostrobelight",connector = "RED_BEACON L",argument = 195,period = 1.5,color = {1.0, 0.0, 0.0},phase_shift = 0.0},
						--{typename = "argnatostrobelight",connector = "RED_BEACON R",argument = 196,period = 1.6,color = {1.0, 0.0, 0.0},phase_shift = 0.0},
							}
			},
--[[			
	[5] = { typename = "collection", -- strobe_lights_default
					lights = {
						{typename  = "strobelight",connector =  "RED_BEACON"  ,argument = 193, color = {0.8,0,0}},-- Arg 193, 83,
						{typename  = "strobelight",connector =  "RED_BEACON_2",argument = 194, color = {0.8,0,0}},-- (-1"RESERV_RED_BEACON")
						{typename  = "strobelight",connector =  "RED_BEACON"  ,argument =  83, color = {0.8,0,0}},-- Arg 193, 83,
							}
			},
--]]			
	}},
}

add_aircraft(Eurofighter)


local function VSN_EFT_PTB(clsid, center)
	local data = {
		category	= CAT_FUEL_TANKS,
		CLSID		= clsid,
		attribute	=  {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
		Picture		= "PTB.png",
		displayName	= _("Fuel Tank 330 gallons"),
		Weight_Empty	= 132,
		Weight			= 132 + 1018,	-- 330 gallons, 6.8 lb/gal 
		Cx_pil		= 0.00141885432,		--1.2*0.001313754,			-- TODO
		shape_table_data = 
		{
			{
				name	= "EFT-ptb";
				file	= "EFT-ptb";
				life	= 1;
				fire	= { 0, 1};
				username	= "EFT-ptb";
				index	= WSTYPE_PLACEHOLDER;
			},
		},
		Elements	= 
		{
			{
				ShapeName	= "EFT-ptb",
			}, 
		}, 
	}
	declare_loadout(data)
end

VSN_EFT_PTB("{VSN_EFT_PTB}")