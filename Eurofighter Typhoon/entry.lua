declare_plugin("Eurofighter Thphoon",
{
displayName     = _("Eurofighter"),
developerName   =   "Gonzalo de Santa Ana",

image     	 = "FC.bmp",
installed 	 = true, -- if false that will be place holder , or advertising
dirName	  	 = current_mod_path,
fileMenuName = _("Eurofighter"),

version		 = "2.5.6",
state		 = "installed",
info		 = _("The Eurofighter Typhoon is a twin-engine, canard–delta wing, multirole fighter. The Typhoon was designed originally as an air superiority fighter and is manufactured by a consortium of Airbus, BAE Systems and Leonardo that conducts the majority of the project through a joint holding company, Eurofighter Jagdflugzeug GmbH. NATO Eurofighter and Tornado Management Agency manages the project and is the prime customer."),

InputProfiles =
{
    ["Eurofighter"] = current_mod_path .. '/Input',
},


Skins	=
	{
		{
			name	= _("Eurofighter"),
			dir		= "Theme"
		},
	},
	

LogBook =
	{
		{
			name		= _("Eurofighter"),
			type		= "Eurofighter",
		},
	},		
})

mount_vfs_texture_path(current_mod_path ..  "/Theme/ME")--for simulator loading window

mount_vfs_model_path    (current_mod_path ..  "/Cockpit/Shape")
mount_vfs_texture_path  (current_mod_path ..  "/Cockpit/Textures/Cockpit_textures")
mount_vfs_model_path (current_mod_path.."/Shapes")
mount_vfs_liveries_path (current_mod_path.."/Liveries")
mount_vfs_texture_path  (current_mod_path.."/Textures/Armamento")
mount_vfs_texture_path  (current_mod_path.."/Textures/SDV_7LWG")
mount_vfs_texture_path  (current_mod_path.."/Textures/VSN_Eurofighter")
mount_vfs_texture_path  (current_mod_path.."/Textures/CrazyEddie EF Skins")
mount_vfs_texture_path  (current_mod_path.."/Textures/Gerritboom EF Skins")
mount_vfs_texture_path  (current_mod_path.."/Textures/EF2000_Air_Force_skins_by_Urbi")

dofile(current_mod_path..'/Eurofighter.lua')
dofile(current_mod_path.."/Weapons.lua")
dofile(current_mod_path.."/Views.lua")
make_view_settings('Eurofighter', ViewSettings, SnapViews)
----------------------------------------------------------------------------------------
make_flyable('Eurofighter', current_mod_path..'/Cockpit/Scripts/',{nil, old = 6}, current_mod_path..'/comm.lua')
----------------------------------------------------------------------------------------
plugin_done()
