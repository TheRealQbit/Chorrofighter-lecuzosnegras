--/N/ jan 2015

-- Headtypes
-- // тип головки самонаведения ГСН:
-- const int InfraredSeeker = 1;    // Thermal IR (infrared seeker)
-- const int ActiveRadar        = 2;    //  (active radar (AR) (+ИНС)) 
-- const int AntiRadar          = 3;    // (Passive radar +INS)
-- const int LaserHoming        = 4;    // Laser illumination (+INS)
-- const int Autopilot          = 5;    // Autonmous (INS+ Card, GPS,TV,IIR...)
-- const int SemiActiveRadar    = 6;    // semi-active radar (SAR) 
-- const int SemiAutoAT	    = 7;	// semi-automatic control with a platform for anti-tank systems , fly to woPoint, coordinates woPoint change platform.

-- Highest possible number seems to be ~25772


local wsType_LYSBOMB = 11030
--11019 = A (01) J (10) S (19) + 11 => 11030
local wsType_BK90 = 11031
local wsType_BK90MJ1 = 11053
local wsType_BK90MJ2 = 11054
local wsType_BK90Test = 11032
local wsType_HEBOMB = 11033
local wsType_HEBOMBDrag = 11034
local wsType_Rb05 = 11035
local wsType_AKAN = 11036
local wsType_AKANPOD = 11055
local wsType_Irdiss = 11037
local wsType_Rb24J = 11038
local wsType_IrisT = 11062
local wsType_Meteor = 11061
local wsType_Aim_132 = 11063
local wsType_Rb04AI = 11042
local wsType_Rb15AI = 11043
local wsType_ARAK70HE = 11044
local wsType_ARAK70HEPOD = 11048
local wsType_KB = 11045
local wsType_U22 = 11046
local wsType_U22A = 11047
local wsType_Brimstone = 11050
local wsType_RB75T = 11051
local wsType_RB75B = 11052

local function calcPiercingMass(warhead)
	warhead.piercing_mass = warhead.mass;
	if (warhead.expl_mass/warhead.mass > 0.1) then
		warhead.piercing_mass = warhead.mass/5.0;
	end
end

local explosivePercent = 1--0.8

function simple_aa_warhead(power, caliber) 
 local res = {};

	res.mass = 1.1*power;
	res.expl_mass = power;
	res.other_factors = {1, 1, 1};
	res.obj_factors = {1, 1};
	res.concrete_factors = {1, 1, 1};
	res.cumulative_factor = 0;
	res.concrete_obj_factor = 0.0;
	res.cumulative_thickness = 0.0;
	res.caliber = caliber;

	calcPiercingMass(res)
 return res;
end

function enhanced_a2a_warhead(power, caliber)
 local res = {};

	res.expl_mass = 1.7*power;
	res.mass = res.expl_mass;
	res.other_factors = {1, 1, 1};
	res.obj_factors = {1, 1};
	res.concrete_factors = {1, 1, 1};
	res.cumulative_factor = 0;
	res.concrete_obj_factor = 0.0;
	res.cumulative_thickness = 0.0;
	res.caliber = caliber;

	calcPiercingMass(res)
 return res;
end

function simple_warhead(power, caliber)
 local res = {};

	res.caliber = caliber
	res.expl_mass = power*explosivePercent; 
	res.mass = res.expl_mass;
	res.other_factors = {1, 1, 1};
	res.obj_factors = {1, 1};
	res.concrete_factors = {1, 1, 1};
	res.cumulative_factor = 0;
	res.concrete_obj_factor = 0.0;
	res.cumulative_thickness = 0.0;

	calcPiercingMass(res)
 return res;
end

function cumulative_warhead(power)
 local res = {};

	res.expl_mass = power*explosivePercent;
	res.mass = res.expl_mass;
	res.other_factors = {1, 1, 1};
	res.obj_factors = {1, 1};
	res.concrete_factors = {1, 1, 1};
	res.cumulative_factor = 3.0;
	res.concrete_obj_factor = 0.0;
	res.cumulative_thickness = 0.2;

	calcPiercingMass(res)
 return res;
end

function penetrating_warhead(power, piercing_mass, caliber)
 local res = {};

	res.expl_mass = power*explosivePercent;
	res.mass = res.expl_mass;
	res.other_factors = {1, 1, 1};
	res.obj_factors = {1, 1};
	res.concrete_factors = {1, 1, 10};
	res.cumulative_factor = 5.0;
	res.concrete_obj_factor = 5.0;
	res.cumulative_thickness = 0.0;
	res.piercing_mass = piercing_mass;
	res.caliber = caliber;

	calcPiercingMass(res)
	return res;
end

function mbd3_full(shape)
	return 	{
		mbd3_u6_adapter,
		mbd3_u6_element(shape,6),
		mbd3_u6_element(shape,5),
		mbd3_u6_element(shape,4),
		mbd3_u6_element(shape,3),
		mbd3_u6_element(shape,2),
		mbd3_u6_element(shape,1),
	}
end

function aircraft_gunpod(gunpod_name, ...)
    local type = _G[gunpod_name];
    if type == nil then
        error("Unknown type for "..gunpod_name);
    end
	aircraft_gunpod_with_wstype(gunpod_name,type,arg)
end

function aircraft_gunpod_with_wstype(gunpod_name,wstype,mounts)
	--print(gunpod_name)
    local res = dbtype("wAircraftGunpodEquipment", {
        ws_type     = wstype;
		gunpod_name  = gunpod_name;
    });
	if not res.short_name then 
		   res.short_name = gunpod_name
	end
	if not res.display_name then 
		   res.display_name = res.short_name
	end
    res.mounts = {};
	
    for i, v in ipairs(mounts) do
        res.mounts[i] = v;
    end
    weapons_table.aircraft_gunpods[gunpod_name] = res
end

warhead = {}
--AA MISSILES
warhead["IrisT"] =  enhanced_a2a_warhead(9.4, 127); 
warhead["Meteor"] =  enhanced_a2a_warhead(9.4, 227);
warhead["Aim_132"] =  enhanced_a2a_warhead(9.4, 127); 


-- ROCKETS
-- MISSILES
local IrisT = { 

	category		= CAT_AIR_TO_AIR,
	name			= "Iris-T",
	user_name		= _("Iris-T"),
	--/N/ wrong -> wsTypeOfWeapon = {4, 4, 11, WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon = {wsType_Weapon,wsType_Missile,wsType_AA_Missile, wsType_IrisT},
	NatoName		=	"(IrisT)",
	

	shape_table_data =
	{
		{
			name	 = "Iris-T";
			file  = "Iris-T"; -- <--/N/ replace this file name with proper one
			life  = 1;
			fire  = { 0, 1};
			username = "Iris-T";
			index = wsType_IrisT,
		},
	},

        Escort = 0,
        Head_Type = 1,
		sigma = {3, 3, 3},
        M = 85.4,
        H_max = 23000.0,
        H_min = -1,
        Diam = 127.0,
        Cx_pil = 2.58,
        D_max = 37336.0,
        D_min = 300.0,
        Head_Form = 0,
        Life_Time = 100.0,
        Nr_max = 40,
        v_min = 140.0,
        v_mid = 1029.0,
        Mach_max = 3.0,
        t_b = 0.0,
        t_acc = 6.0,
        t_marsh = 0.0,
        Range_max = 40000.0,
        H_min_t = 1.0,
        Fi_start = 0.3,
        Fi_rak = 3.14152,
        Fi_excort = 0.79,
        Fi_search = 0.09,
        OmViz_max = 0.61,
        warhead = warhead["IrisT"],
        exhaust = { 0.84, 0.66, 0.43, 0.08 };	
        X_back = -1.455,
        Y_back = -0.062,
        Z_back = 0,
        Reflection = 0.0182,
        KillDistance = 5.0,
		--seeker sensivity params
		SeekerSensivityDistance = 90000, -- The range of target with IR value = 1. In meters. In forward hemisphere.
		ccm_k0 = 0.05,  -- Counter Countermeasures Probability Factor. Value = 0 - missile has absolutely resistance to countermeasures. Default = 1 (medium probability)
		SeekerCooled			= true, -- True is cooled seeker and false is not cooled seeker.				
		ModelData = {   58 ,  -- model params count
						0.35 ,   -- characteristic square (õàðàêòåðèñòè÷åñêàÿ ïëîùàäü)
						
						-- ïàðàìåòðû çàâèñèìîñòè Ñx
						0.04 , -- Cx_k0 ïëàíêà Ñx0 íà äîçâóêå ( M << 1)
						0.08 , -- Cx_k1 âûñîòà ïèêà âîëíîâîãî êðèçèñà
						0.02 , -- Cx_k2 êðóòèçíà ôðîíòà íà ïîäõîäå ê âîëíîâîìó êðèçèñó
						0.05, -- Cx_k3 ïëàíêà Cx0 íà ñâåðõçâóêå ( M >> 1)
						1.2 , -- Cx_k4 êðóòèçíà ñïàäà çà âîëíîâûì êðèçèñîì 
						1.0 , -- êîýôôèöèåíò îòâàëà ïîëÿðû (ïðîïîðöèîíàëüíî sqrt (M^2-1))
						
						-- ïàðàìåòðû çàâèñèìîñòè Cy
						0.9 , -- Cy_k0 ïëàíêà Ñy0 íà äîçâóêå ( M << 1)
						0.8	 , -- Cy_k1 ïëàíêà Cy0 íà ñâåðõçâóêå ( M >> 1)
						1.2  , -- Cy_k2 êðóòèçíà ñïàäà(ôðîíòà) çà âîëíîâûì êðèçèñîì  
						
						0.4 , -- 7 Alfa_max  ìàêñèìàëüíûé áàëàíñèðîâà÷íûé óãîë, ðàäèàíû
						0.0, --óãëîâàÿ ñêîðîñòü ñîçäàâàéìàÿ ìîìåíòîì ãàçîâûõ ðóëåé
						
					-- Engine data. Time, fuel flow, thrust.	
					--	t_statr		t_b		t_accel		t_march		t_inertial		t_break		t_end			-- Stage
						-1.0,		-1.0,	10,  		0.0,		0.0,			0.0,		1.0e9,         -- time of stage, sec
						 0.0,		0.0,	5.44,		0.0,		0.0,			0.0,		0.0,           -- fuel flow rate in second, kg/sec(ñåêóíäíûé ðàñõîä ìàññû òîïëèâà êã/ñåê)
						 0.0,		0.0,	17000.0,	0.0,	0.0,			0.0,		0.0,           -- thrust, newtons
					
						 1.0e9, -- òàéìåð ñàìîëèêâèäàöèè, ñåê
						 60.0, -- âðåìÿ ðàáîòû ýíåðãîñèñòåìû, ñåê
						 0, -- àáñîëþòíàÿ âûñîòà ñàìîëèêâèäàöèè, ì
						 0.3, -- âðåìÿ çàäåðæêè âêëþ÷åíèÿ óïðàâëåíèÿ (ìàíåâð îòëåòà, áåçîïàñíîñòè), ñåê
						 1.0e9, -- äàëüíîñòü äî öåëè â ìîìåíò ïóñêà, ïðè ïðåâûøåíèè êîòîðîé ðàêåòà âûïîëíÿåòñÿ ìàíåâð "ãîðêà", ì
						 1.0e9, -- äàëüíîñòü äî öåëè, ïðè êîòîðîé ìàíåâð "ãîðêà" çàâåðøàåòñÿ è ðàêåòà ïåðåõîäèò íà ÷èñòóþ ïðîïîðöèîíàëüíóþ íàâèãàöèþ (äîëæåí áûòü áîëüøå èëè ðàâåí ïðåäûäóùåìó ïàðàìåòðó), ì 
						 0.0,  -- ñèíóñ óãëà âîçâûøåíèÿ òðàåêòîðèè íàáîðà ãîðêè
						 30.0, -- ïðîäîëüíîå óñêîðåíèÿ âçâåäåíèÿ âçðûâàòåëÿ
						 0.0, -- ìîäóëü ñêîðîñòè ñîîáùàéìûé êàòàïóëüòíûì óñòðîéñòâîì, âûøèáíûì çàðÿäîì è òä
						 1.19, -- õàðàêòðèñòèêà ñèñòåìû ÑÀÓ-ÐÀÊÅÒÀ,  êîýô ôèëüòðà âòîðîãî ïîðÿäêà K0
						 1.0, -- õàðàêòðèñòèêà ñèñòåìû ÑÀÓ-ÐÀÊÅÒÀ,  êîýô ôèëüòðà âòîðîãî ïîðÿäêà K1
						 2.0, -- õàðàêòðèñòèêà ñèñòåìû ÑÀÓ-ÐÀÊÅÒÀ,  ïîëîñà ïðîïóñêàíèÿ êîíòóðà óïðàâëåíèÿ
						 0.0,
						 0.0,
						 0.0,
						 0.0,
						 0.0,
						 -- DLZ. Äàííûå äëÿ ðàññ÷åòà äàëüíîñòåé ïóñêà (èíäèêàöèÿ íà ïðèöåëå)
						 11000.0, -- äàëüíîñòü ðàêóðñ   180(íàâñòðå÷ó) ãðàä,  Í=10000ì, V=900êì/÷, ì
						 5000.0, -- äàëüíîñòü ðàêóðñ 0(â äîãîí) ãðàä,  Í=10000ì, V=900êì/÷, ì
						 5000.0, -- äàëüíîñòü ðàêóðñ 	180(íàâñòðå÷ó) ãðàä, Í=1000ì, V=900êì/÷, ì
						 0.2, -- Óìåíüøåíèå ðàçðåøåííîé äàëüíîñòè ïóñêà ïðè îòêëîíåíèè âåêòîðà ñêîðîñòè íîñèòåëÿ îò ëèíèè âèçèðîâàíèÿ öåëè.
						 1.0, -- Âåðòèêàëüíàÿ ïëîñêîñòü. Íàêëîí êðèâîé ðàçðåøåííîé äàëüíîñòè ïóñêà â íèæíþþ ïîëóñôåðó. Óìåíüøåíèå äàëüíîñòè ïðè ñòðåëüáå âíèç.
						 1.4, -- Âåðòèêàëüíàÿ ïëîñêîñòü. Íàêëîí êðèâîé ðàçðåøåííîé äàëüíîñòè ïóñêà â âåðõíþþ ïîëóñôåðó. Óâåëè÷åíèå äàëüíîñòè ïðè ñòðåëüáå ââåðõ.
						-3.0, -- Âåðòèêàëüíàÿ ïëîñêîñòü. Óãîë ïåðåãèáà êðèâîé ðàçðåøåííîé äàëüíîñòè, âåðõíÿÿ - íèæíÿÿ ïîëóñôåðà.
						0.5, -- Èçìåíåíèå êîýôôèöèåíòîâ íàêëîíà êðèâîé â âåðõíþþ è íèæíþþ ïîëóñôåðû îò âûñîòû íîñèòåëÿ.
					},
		
		
	
}

declare_weapon(IrisT)

declare_loadout(
	{		
		category			= CAT_AIR_TO_AIR,
		CLSID				= "{irist}",
		attribute			= {wsType_Weapon, wsType_Missile, wsType_Container, wsType_IrisT},
		wsTypeOfWeapon		= IrisT.wsTypeOfWeapon,
		Count				= 1,
		Picture				= "irist.png",
		displayName			= IrisT.user_name.._(""), --<-- /N/  put the launcher name here if any
		Weight				= 90, --<--/N/ missile + launcher weight (if any), this is important since the launcher stays on  aircraft! So this weight should be higher than a missile itself!
		Cx_pil				= 0.01, --<--/N/ this is too low, you might have difficulties later to set up the human and AI FM (ignore the 21 code when it comes to weapons Cx, it is a special case) -- edited Jedi
		Elements			={
			[1]	=
			{
				Position	=	{0.0,	0.0,	0}, 
				ShapeName	=	"Iris-T", --<-- /N/  put the missile shape name here
			},
		},
	}
)

--test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...--
--test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...--
--test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...--
local Meteor = { 

	category		= CAT_AIR_TO_AIR,
	name			= "Meteor",
	user_name		= _("Meteor"),
	--/N/ wrong -> wsTypeOfWeapon = {4, 4, 11, WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon = {wsType_Weapon,wsType_Missile,wsType_AA_Missile, wsType_Meteor},
	NatoName		=	"(Meteor)",
	

	shape_table_data =
	{
		{
			name	 = "Meteor";
			file  = "Meteor"; -- <--/N/ replace this file name with proper one
			life  = 1;
			fire  = { 0, 1};
			username = "Meteor";
			index = wsType_Meteor,
		},
	},

        Escort = 1,
        Head_Type = 2,
		sigma = {1000, 10, 10},
        M = 520.0,
        H_max = 28000.0,  	-- max altitude (m)
        H_min = 10,			--min altitude (m)
        Diam = 380.0,		
        Cx_pil = 5,			--drag on pylon
        D_max = 55560.0,
        D_min = 6000.0,
        Head_Form = 1,
        Life_Time = 500.0,  
        Nr_max = 12,
        v_min = 140.0,
        v_mid = 1715.0,
        Mach_max = 5,
        t_b = 0.1,
        t_acc = 13.0,
        t_marsh = 25.0,
        Range_max = 160000.0,
        H_min_t = 25.0,
        Fi_start = 0.3,
        Fi_rak = 3.14152,
        Fi_excort = 0.87,
        Fi_search = 0.1,
        OmViz_max = 0.35,
        warhead = warhead["Meteor"],
		Engine_Type = 3,
        exhaust = { 0.8, 0.8, 0.8, 0.8 }; --RGB+Intensity
        X_back = -1.85,   	--pos in X axis(F/B)
        Y_back = -0.145,	--pos in Y axis(U/D)
        Z_back = 0.0,		--pos in Z axis(L/R)
        Reflection = 0.079,
        KillDistance = 12.0,
		ccm_k0 = 0.0,
			
		ModelData = {   58 ,  -- model params count
						1.1 ,   -- characteristic square (характеристическая площадь)
						
						-- параметры зависимости Сx         									- parameters of the Cx dependence
						0.07 , -- Cx_k0 планка Сx0 на дозвуке ( M << 1) 							- Cx_k0 bar Cx0 on subsonic (M << 1)
						0.08 , -- Cx_k1 высота пика волнового кризиса 								- Cx_k1 height of the peak of the wave crisis
						0.02 , -- Cx_k2 крутизна фронта на подходе к волновому кризису 				- Cx_k2 steepness of the front on the approach to the wave crisis
						0.012, -- Cx_k3 планка Cx0 на сверхзвуке ( M >> 1) 							- Cx_k3 bar Cx0 at supersonic (M >> 1)
						2.5 , -- Cx_k4 крутизна спада за волновым кризисом 							- Cx_k4 steepness of the decline after the wave crisis
						1.2 , -- коэффициент отвала поляры (пропорционально sqrt (M^2-1))			- the coefficient of dumping polar (proportional to sqrt (M ^ 2-1))
						
						-- параметры зависимости Cy												- parameters of the dependence Cy
						0.6 , -- Cy_k0 планка Сy0 на дозвуке ( M << 1)								- Cy_k0 bar Сy0 on subsonic (M << 1)
						0.3	 , -- Cy_k1 планка Cy0 на сверхзвуке ( M >> 1)							- Cy_k1 bar Cy0 at supersonic (M >> 1)
						1.2  , -- Cy_k2 крутизна спада(фронта) за волновым кризисом  				- Cy_k2 steepness of the decline (front) behind the wave crisis
						0.2 , -- 7 Alfa_max  максимальный балансировачный угол, радианы 			- 7 Alfa_max maximum balancing angle, radians
						0.0, --угловая скорость создаваймая моментом газовых рулей					- the angular velocity created by the moment of gas rudders
						
					-- Engine data. Time, fuel flow, thrust.	
					--	t_statr		t_b		t_accel		t_march		t_inertial		t_break		t_end			-- Stage
						-1.0,		-1.0,	12.0,  		37.0,		6.0,			0.0,		1.0e9,         -- time of stage, sec
						 0.0,		0.0,	1.0,		3.0,		0.0,			0.0,		0.0,           -- fuel flow rate in second, kg/sec(секундный расход массы топлива кг/сек)
						 0.0,		0.0,	70000.0,	12000.0,	6000.0,			0.0,		0.0,           -- thrust, newtons
					
						 1.0e9, -- таймер самоликвидации, сек									- self-destruction timer, sec
						 120.0, -- время работы энергосистемы, сек								- power system operation time, sec
						 0, -- абсолютная высота самоликвидации, м								- absolute height of self-liquidation, m
						 2.5, -- время задержки включения управления (маневр отлета, безопасности), сек				- delay time of control activation (departure maneuver, safety), sec
						 80000.0, -- дальность до цели в момент пуска, при превышении которой ракета выполняется маневр "горка", м		is the range to the target at the moment of launch, when exceeding which the missile performs a "slide" maneuver, m
						 80000.0, -- дальность до цели, при которой маневр "горка" завершается и ракета переходит на чистую пропорциональную навигацию (должен быть больше или равен предыдущему параметру), м 			, is the range to the target at which the "slide" maneuver is completed and the missile switches to pure proportional navigation (must be greater than or equal to the previous parameter), m
						 0.15,  -- синус угла возвышения траектории набора горки									- sine of the elevation angle of the trajectory of the slide
						 30.0, -- продольное ускорения взведения взрывателя											- longitudinal acceleration of the fuse cocking
						 0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд			- the speed module communicated by the ejection device, expelling charge, etc.
						 1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0				- characteristic of the ACS-RAKETA system, the coefficient of the second order filter K0
						 1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1					- characteristic of the SAU-RAKETA system, second-order filter coefficient K1
						 2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления			- characteristic of the SAU-RAKETA system, bandwidth of the control loop
						 0.0, -- flight range to the horizon with available Navail overload> = 1.0 at an altitude of H = 2000
						 0.0, -- is the slope of the dependence of the flight range to the horizon with the available Navail overload> = 1.0 on the height H
						 0.0, -- 
						 0.0, -- dimensionless coefficient. efficiency of self-propelled guns rocket
						 0.0, -- calculation of flight time
						  -- DLZ. Данные для рассчета дальностей пуска (индикация на прицеле)      -Data for calculating launch ranges (indication on the sight)
						 1.0, -- range angle 180 (towards) deg, H = 10000m, V = 900km / h, m
						 1.0, -- distance angle 0 (in catch-up) deg, H = 10000m, V = 900km / h, m
						 1.0, -- range angle 180 (towards) deg, H = 1000m, V = 900km / h, m
						 0.2, -- Reduction of the allowed launch range when the carrier velocity vector deviates from the target's line of sight.
						 0.6, -- Vertical plane. Slope of the curve of the allowed launch range into the lower hemisphere. Reduced range when firing down.
						 1.4, -- Vertical plane. Slope of the curve of the allowed launch range into the upper hemisphere. Increased range when firing upwards.
						-3.0, -- Vertical plane. Bend angle of the permitted range curve, upper - lower hemisphere.
						0.5,  --- Changing the slope coefficients of the curve in the upper and lower hemispheres from the height of the carrier.
					},
		
		
	
}

declare_weapon(Meteor)

declare_loadout(
	{		
		category			= CAT_AIR_TO_AIR,
		CLSID				= "{Meteor}",
		attribute			= {wsType_Weapon, wsType_Missile, wsType_Container, wsType_Meteor},
		wsTypeOfWeapon		= Meteor.wsTypeOfWeapon,
		Count				= 1,
		Picture				= "meteor.png",
		displayName			= Meteor.user_name.._(""), --<-- /N/  put the launcher name here if any
		Weight				= 90, --<--/N/ missile + launcher weight (if any), this is important since the launcher stays on  aircraft! So this weight should be higher than a missile itself!
		Cx_pil				= 0.0001, --<--/N/ this is too low, you might have difficulties later to set up the human and AI FM (ignore the 21 code when it comes to weapons Cx, it is a special case) -- edited Jedi
		Elements			={
			[1]	=
			{
				Position	=	{0.0,	0.01,	0}, 
				ShapeName	=	"Meteor", --<-- /N/  put the missile shape name here
			},
		},
	}
)
--test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...--
--test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...--
--test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...test...--


local Aim_132 = { 

	category		= CAT_AIR_TO_AIR,
	name			= "Aim_132",
	user_name		= _("Aim_132"),
	--/N/ wrong -> wsTypeOfWeapon = {4, 4, 11, WSTYPE_PLACEHOLDER},
	wsTypeOfWeapon = {wsType_Weapon,wsType_Missile,wsType_AA_Missile, wsType_Aim_132},
	NatoName		=	"(Aim_132)",
	

	shape_table_data =
	{
		{
			name	 = "Aim_132";
			file  = "Aim_132"; -- <--/N/ replace this file name with proper one
			life  = 1;
			fire  = { 0, 1};
			username = "Aim_132";
			index = wsType_Aim_132,
		},
	},

        Escort = 1,
        Head_Type = 1,
		sigma = {5.6, 5, 5.6},
        M = 230.0,
        H_max = 24400.0,
        H_min = 1.0,
        Diam = 203.0,
        Cx_pil = 2.21,
        D_max = 20000.0,
        D_min = 700.0,
        Head_Form = 1,
        Life_Time = 120.0,
        Nr_max = 25,
        v_min = 140.0,
        v_mid = 500.0,
        Mach_max = 3.5,
        t_b = 0.0,
        t_acc = 3.3,
        t_marsh = 11.0,
        Range_max = 18000.0,
        H_min_t = 15.0,
        Fi_start = 0.4,
        Fi_rak = 3.14152,
        Fi_excort = 1.05,
        Fi_search = 0.1,
        OmViz_max = 0.35,
        warhead = warhead["Aim_132"],
        exhaust = {0.78, 0.78, 0.78, 0.3};
        X_back = -1.8,
        Y_back = -0.11, --0.0,
        Z_back = 0.0, -- -0.1,
        Reflection = 0.0366,
        KillDistance = 12.0,
		ccm_k0 = 0.03,  -- Counter Countermeasures Probability Factor. Value = 0 - missile has absolutely resistance to countermeasures. Default = 1 (medium probability)
		ModelData = {   58 ,  -- model params count
						0.9 ,   -- characteristic square (характеристическая площадь)
				
						-- параметры зависимости Сx
						0.03 , -- планка Сx0 на дозвуке ( M << 1)
						0.08 , -- высота пика волнового кризиса
						0.02 , -- крутизна фронта на подходе к волновому кризису
						0.03 , -- планка Cx0 на сверхзвуке ( M >> 1)
						2.5  , -- крутизна спада за волновым кризисом 
						1.0  , -- коэффициент отвала поляры
						
						-- параметры зависимости Cy
						0.7 , -- планка Сy0 на дозвуке ( M << 1)
						0.6	 , -- планка Cy0 на сверхзвуке ( M >> 1)
						1.2  , -- крутизна спада(фронта) за волновым кризисом  

						0.29 , -- 7 Alfa_max  максимальный балансировачный угол, радианы
						0.0, --угловая скорость создаваймая моментом газовых рулей
						
					--	t_statr   t_b      t_accel  t_march   t_inertial   t_break  t_end
						-1.0,    -1.0 ,  	3.26  ,  10.86,      0.0,		   0.0,      1.0e9,           -- time interval
						 0.0,     0.0 ,   	11.8 ,  2.0,     0.0,         0.0,      0.0,           -- fuel flow rate in second kg/sec(секундный расход массы топлива кг/сек)
						 0.0,     0.0 ,   30645.0,  5194.0,   0.0,         0.0,      0.0,           -- thrust
					
						 1.0e9, -- таймер самоликвидации, сек
						 75.0, -- время работы энергосистемы
						 0.0, -- абсалютеая высота самоликвидации, м
						 1.5, -- время задержки включения управленя, сек
						 1.0e9, -- дальность до цели в момент пуска, выше которой выполняется маневр набора высоты 
						 1.0e9, -- дальность до цели на трассе, менее которой начинается завершение маневра набора высоты (длжен быть больше чем предылущий параметр) 
						 0.0,  -- синус угла возвышения траектории набора горки
						 50.0, -- продольное ускорения взведения взрывателя
						 0.0, -- модуль скорости сообщаймый катапультным устройством, вышибным зарядом и тд
						 1.19, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K0
						 1.0, -- характристика системы САУ-РАКЕТА,  коэф фильтра второго порядка K1
						 2.0, -- характристика системы САУ-РАКЕТА,  полоса пропускания контура управления
						 6800.0, -- дальность полета в горизонт с располагаемой перегрузкой Navail >= 1.0 на высоте H=2000
						 3.8, -- крутизна зависимости  дальность полета в горизонт с располагаемой перегрузкой Navail >= 1.0 от высоты H
						 30.0, --  коэф поправки к дальности от скорости носителя
						 0.75, -- безразмерный коэф. эффективности САУ ракеты
						 43.0, -- Прогноз времени полета ракеты 
						  -- DLZ. Данные для рассчета дальностей пуска (индикация на прицеле)
						 50000.0, -- дальность ракурс   180(навстречу) град,  Н=10000м, V=900км/ч, м
						 18000.0, -- дальность ракурс 0(в догон) град,  Н=10000м, V=900км/ч
						 20000.0, -- дальность ракурс 	180(навстречу) град, Н=1000м, V=900км/ч
						 0.2,     -- Коэффициент уменьшения дальности при увеличения угла между векторм скорости носителя и линией визирования цели
						 0.7, -- Вертикальная плоскость. Наклон кривой разрешенной дальности пуска в нижнюю полусферу. Уменьшение дальности при стрельбе вниз.
						 2.0, -- Вертикальная плоскость. Наклон кривой разрешенной дальности пуска в верхнюю полусферу. Увеличение дальности при стрельбе вверх.
						-3.0, -- Вертикальная плоскость. Угол перегиба кривой разрешенной дальности, верхняя - нижняя полусфера.
						0.5, -- Изменение коэффициентов наклона кривой в верхнюю и нижнюю полусферы от высоты носителя.
					},
		
		
	
}

declare_weapon(Aim_132)

declare_loadout(
	{		
		category			= CAT_AIR_TO_AIR,
		CLSID				= "{aim132}",
		attribute			= {wsType_Weapon, wsType_Missile, wsType_Container, wsType_Aim_132},
		wsTypeOfWeapon		= Aim_132.wsTypeOfWeapon,
		Count				= 1,
		Picture				= "aim9m.png",
		displayName			= Aim_132.user_name.._("AIM132"), --<-- /N/  put the launcher name here if any
		Weight				= 90, --<--/N/ missile + launcher weight (if any), this is important since the launcher stays on  aircraft! So this weight should be higher than a missile itself!
		Cx_pil				= 0.001, --<--/N/ this is too low, you might have difficulties later to set up the human and AI FM (ignore the 21 code when it comes to weapons Cx, it is a special case) -- edited Jedi
		Elements			={
			[1]	=
			{
				Position	=	{0.0,	0.0,	0}, 
				ShapeName	=	"Aim_132", --<-- /N/  put the missile shape name here
			},
		},
	}
)







-- AG MISSILES

warhead["huge"] = simple_warhead(700*12,450)

warhead["m71"] = simple_warhead(125,450); -- Explosive 60 kg + fragments bonus

warhead["none"] = simple_warhead(1,1)

warhead["brimstone"] = penetrating_warhead(97,305)

declare_loadout(
    {
        category = CAT_FUEL_TANKS,
        CLSID = "{EF_CENTRAL_TANK}",
        attribute = {wsType_Air,wsType_Free_Fall,wsType_FuelTank,WSTYPE_PLACEHOLDER},
        Picture = "Xtank.png",
		Diam = 606.0,
        displayName = _("Tanque_1000L"),
        Weight_Empty = 195,
        Weight = 1190,
        Cx_pil            = 0.00016,--0.002197266, -- Ragnar: I've calculated it to be exactly this much // changed to F-5 tank Cx -- Teo// testing
        shape_table_data =
            {
                {
                    file = "EF_CENTRAL_TANK",
                    life = 1,
                    fire = { 0, 1},
                    username = "EF_CENTRAL_TANK",
                    index = WSTYPE_PLACEHOLDER,
                },
            },
        Elements =
            {
                {
                DrawArgs =
                    {
                        [1] = {1, 1},
                        [2] = {2, 1},
                    },
                        Position = {0, 0, 0},
                        ShapeName = "EF_CENTRAL_TANK",
                    },
                },
            }
)
local brimstone = { 

	category		= CAT_MISSILES,
	name			= "brimstone",
	user_name		= _("Brimstone"),
	wsTypeOfWeapon = {4, 4, 8, wsType_brimstone},--{4, 4, 8, WSTYPE_PLACEHOLDER},
	NatoName		=	"(Brimstone)",
	
	shape_table_data =
	{
		{
			name	 = "brimstone";
			file  = "brimstone";
			life  = 1;
			fire  = { 0, 1};
			username = "brimstone";
			index = WSTYPE_PLACEHOLDER,
		},
	},

	Escort = 0,
	Head_Type = 4, --/N/ 6 semi active radar, 4 laser /OR/ 7 semi auto
	sigma = {3, 3, 3},--{1.27, 1.55, 1.27},
	M = 210.0,
	H_max = 17000.0,
	H_min = -1,
	Diam = 305.0,
	Cx_pil = 4, -- <--/N/  
	D_max = 16321.0,0, -- <--/N/ max launch distance, correct if needed
	D_min = 300.0, -- <--/N/ min launch distance
	Head_Form = 0, -- <--/N/ 1- cone, 0 - semi-sphere
	Life_Time = 210.0,
	Nr_max = 16,
	v_min = 50.0,--, -- <--/N/ min speed in m/s
	v_mid = 610,-- -- <--/N/ max speed in m/s
	Mach_max = 1.6,--
	t_b = 0.57,
	t_acc = 9.4, -- 10. Rocket burn-time?
	t_marsh = .00,
	Range_max = 24000.0, -- 
	H_min_t = 1.0,
	Fi_start = 0.5,
	Fi_rak = 3.14152,
	Fi_excort = 1.55,
	Fi_search = 99.9,
	OmViz_max = 99.9,
	warhead = warhead["brimstone"],
	Engine_Type = 1, -- 1 Solid fuel, 2 liquid fuel, 3 ramjet, 4 Acceleator + LRE, 5 turbojet, 6 turbojet + accelerator
	exhaust = { 0.75, 0.75, 0.75, 0.2},
	X_back = -1.50,
	Y_back = -0.00,
	Z_back = 0.0,
	X_back_acc_	= -1.50,
	Y_back_acc_ = -0.0,
	Z_back_acc_ = 0.0,
	Reflection = 0.12044,
	KillDistance = 1.0,

	
}

declare_weapon(brimstone)

declare_loadout(
	{		
		category			= CAT_MISSILES,
		CLSID				= "{brimstone}",
		attribute			= {wsType_Weapon, wsType_Missile, wsType_Container, wsType_brimstone},
		wsTypeOfWeapon		= brimstone.wsTypeOfWeapon,
		Count				= 1,
		Picture				= "agm65.png",
		displayName			= brimstone.user_name.._(" "), --<-- /N/  put the launcher name here if any
		Weight				= 210,
		Cx_pil				= 0.001, -- Edited
		Elements			={
			[1]	=
			{
				Position	=	{0, 0, 0},
				ShapeName	=	"brimstonelauncher", --<-- /N/  put the launcher shape name here if any
				IsAdapter 	= true,
			},
			[2]	=
			{
				Position	=	{-0.075,	-0.208,	0},--{0.075,	-0.148,	0},
				ShapeName	=	"brimstone",
			},
		},
	}
)
declare_loadout(
	{		
		category			= CAT_MISSILES,
		CLSID				= "{brimstonex3}",
		attribute			= {wsType_Weapon, wsType_Missile, wsType_Container, wsType_brimstone},
		wsTypeOfWeapon		= brimstone.wsTypeOfWeapon,
		Count				= 1,
		Picture				= "agm65.png",
		displayName			= brimstone.user_name.._("x3"), --<-- /N/  put the launcher name here if any
		Weight				= 210,
		Cx_pil				= 0.001, -- Edited
		Elements			={
			[1]	=
			{
				Position	=	{0, 0, 0},
				ShapeName	=	"brimstonelauncher", --<-- /N/  put the launcher shape name here if any
				IsAdapter 	= true,
			},
			[2]	=
			{
				Position	=	{0.336,	-0.15,	0,007},--{0.075,	-0.148,	0},
				ShapeName	=	"brimstone",
			},
			[3]	=
			{
				Position	=	{0.336,	-0.068,	-0,35},--{0.075,	-0.148,	0},
				ShapeName	=	"brimstone",
			},
			[4]	=
			{
				Position	=	{0.336,	-0.068,	0,35},--{0.075,	-0.148,	0},
				ShapeName	=	"brimstone",
			},
			
		},
	}
)




