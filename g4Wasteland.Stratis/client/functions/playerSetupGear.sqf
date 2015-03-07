// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: playerSetupGear.sqf
//	@file Author: [GoT] JoSchaap, AgentRev

private ["_player", "_uniform", "_vest", "_headgear", "_goggles", "_donatorLevel"];
_player = _this;

_donatorEnabled = ["A3W_donatorEnabled"] call isConfigOn;
_donatorLevel = player getVariable ["donator", 0];


// Clothing is now defined in "client\functions\getDefaultClothing.sqf"

_uniform = [_player, "uniform"] call getDefaultClothing;
_vest = [_player, "vest"] call getDefaultClothing;
_headgear = [_player, "headgear"] call getDefaultClothing;
_goggles = [_player, "goggles"] call getDefaultClothing;

if (_uniform != "") then { _player addUniform _uniform };
if (_vest != "") then { _player addVest _vest };
if (_headgear != "") then { _player addHeadgear _headgear };
if (_goggles != "") then { _player addGoggles _goggles };

sleep 0.1;

// Remove GPS
_player unlinkItem "ItemGPS";

// Remove radio
//_player unlinkItem "ItemRadio";

// Remove NVG
if (hmd _player != "") then { _player unlinkItem hmd _player };

// Add NVG
// _player linkItem "NVGoggles";

switch (_donatorLevel) do
{
	case 1:
	{
			_player addBackpack "B_Bergen_sgg";
			if (["_diver_", typeOf _player] call fn_findString != -1) then {} else 
			{
			_player addVest "V_HarnessOGL_brn";
			};
			// _player addVest "V_PlateCarrierIAGL_dgtl";
			// _player forceAddUniform "U_BG_Guerilla2_1";
			_player addWeapon "hgun_Pistol_heavy_01_F";
			// _player addPrimaryWeaponItem "optic_Arco";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			// _player addItemtoBackpack "HandGrenade";
			// _player addItemtoBackpack "HandGrenade";
			// _player addWeapon "hgun_mas_glocksf_F";
			_player addHandgunItem "optic_MRD";
			// _player addHandgunItem "optic_Yorris";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addItem "Medikit";
			_player addWeapon "Rangefinder";
			_player addItemToBackpack "FirstAidKit";
			_player addItemToBackpack "FirstAidKit";
			// _player addHeadgear "H_HelmetB";
			_player addGoggles "G_mas_wpn_wrap_mask_t";
			_player linkItem "ItemGPS";
			_player selectWeapon "hgun_Pistol_heavy_01_F";
	};
	case 2:
	{
			_player addBackpack "B_FieldPack_khk";
			if (["_diver_", typeOf _player] call fn_findString != -1) then {} else 
			{
			_player addVest "V_HarnessOGL_brn";
			};
			// _player addVest "V_PlateCarrierIAGL_dgtl";
			// _player forceAddUniform "U_BG_Guerilla2_1";
			_player addWeapon "hgun_Pistol_heavy_01_F";
			// _player addPrimaryWeaponItem "optic_Arco";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			// _player addItemtoBackpack "HandGrenade";
			// _player addItemtoBackpack "HandGrenade";
			// _player addWeapon "hgun_mas_glocksf_F";
			_player addHandgunItem "optic_MRD";
			// _player addHandgunItem "optic_Yorris";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			// _player addItem "Medikit";
			_player addWeapon "Rangefinder";
			_player linkItem "ItemGPS";
			_player addItemToBackpack "FirstAidKit";
			_player addItemToBackpack "FirstAidKit";
			// _player addHeadgear "H_HelmetB";
			_player addItem "NVGoggles";
			_player addGoggles "G_mas_wpn_wrap_mask_t";			
			_player selectWeapon "hgun_Pistol_heavy_01_F";
	};
	case 3:
	{
			_player addBackpack "B_Kitbag_rgr";
			if (["_diver_", typeOf _player] call fn_findString != -1) then {} else 
			{
			_player addVest "V_TacVest_brn";
			};
			// _player forceAddUniform "U_BG_Guerilla2_1";
			_player addWeapon "hgun_Pistol_heavy_01_F";
			// _player addPrimaryWeaponItem "optic_Arco";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			// _player addItemtoBackpack "HandGrenade";
			// _player addItemtoBackpack "HandGrenade";
			// _player addWeapon "hgun_mas_glocksf_F";
			_player addHandgunItem "optic_MRD";
			_player addHandgunItem "muzzle_snds_acp";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addItem "Medikit";
			_player addWeapon "Laserdesignator";
			_player linkItem "ItemGPS";
			// _player addItemToBackpack "FirstAidKit";
			// _player addItemToBackpack "FirstAidKit";
			_player addHeadgear "H_HelmetSpecB_blk";
			_player addItem "NVGoggles";
			_player addGoggles "G_mas_wpn_wrap_mask_t";			
			_player selectWeapon "hgun_Pistol_heavy_01_F";
	};
	case 4:
	{
			_player addBackpack "B_Carryall_oli";
			if (["_diver_", typeOf _player] call fn_findString != -1) then {} else 
			{
			_player addVest "V_PlateCarrier3_rgr";
			};
			// _player forceAddUniform "U_BG_Guerilla2_1";
			_player addWeapon "hgun_Pistol_heavy_01_F";
			// _player addPrimaryWeaponItem "optic_Arco";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			// _player addItemtoBackpack "HandGrenade";
			// _player addItemtoBackpack "HandGrenade";
			// _player addWeapon "hgun_mas_glocksf_F";
			_player addHandgunItem "optic_MRD";
			_player addHandgunItem "muzzle_snds_acp";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addItem "Medikit";
			_player addWeapon "Laserdesignator";
			_player linkItem "ItemGPS";
			// _player addItemToBackpack "FirstAidKit";
			// _player addItemToBackpack "FirstAidKit";
			_player addHeadgear "H_HelmetLeaderO_ocamo";
			_player addItem "NVGoggles";
			_player addGoggles "G_mas_wpn_wrap_mask_t";			
			_player selectWeapon "hgun_Pistol_heavy_01_F";	
	};
	case 5: // Sniper
	{
			_player addBackpack "B_Carryall_oli";
			if (["_diver_", typeOf _player] call fn_findString != -1) then {} else 
			{
			_player addVest "V_Chestrig_rgr";
			};
			_player forceAddUniform "U_I_GhillieSuit";
			_player addWeapon "hgun_Pistol_heavy_01_F";
			// _player addPrimaryWeaponItem "optic_Arco";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			// _player addItemtoBackpack "HandGrenade";
			// _player addItemtoBackpack "HandGrenade";
			// _player addWeapon "";
			_player addHandgunItem "optic_MRD";
			_player addHandgunItem "muzzle_snds_acp";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addItem "Medikit";
			_player addWeapon "Laserdesignator";
			_player linkItem "ItemGPS";
			// _player addItemToBackpack "FirstAidKit";
			// _player addItemToBackpack "FirstAidKit";
			_player addHeadgear "H_HelmetLeaderO_ocamo";
			_player addItem "NVGoggles";
			_player addGoggles "G_mas_wpn_wrap_mask_t";			
			_player selectWeapon "hgun_Pistol_heavy_01_F";	
	};
	case 6: // Tron
	{
			_player addBackpack "B_Carryall_oli";
			if (["_diver_", typeOf _player] call fn_findString != -1) then {} else 
			{
			_player addVest "V_PlateCarrier3_rgr";
			};
			_player forceAddUniform "U_B_Protagonist_VR";
			_player addWeapon "hgun_Pistol_heavy_01_F";
			// _player addPrimaryWeaponItem "optic_Arco";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			// _player addItemtoBackpack "HandGrenade";
			// _player addItemtoBackpack "HandGrenade";
			// _player addWeapon "";
			_player addHandgunItem "optic_MRD";
			_player addHandgunItem "muzzle_snds_acp";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addItem "Medikit";
			_player addWeapon "Laserdesignator";
			_player linkItem "ItemGPS";
			// _player addItemToBackpack "FirstAidKit";
			// _player addItemToBackpack "FirstAidKit";
			_player addHeadgear "H_CrewHelmetHeli_I";
			_player addItem "NVGoggles";
			_player addGoggles "G_mas_wpn_wrap_mask_t";			
			_player selectWeapon "hgun_Pistol_heavy_01_F";	
	};
	case 7: // Pilot
	{
			_player addBackpack "B_Carryall_oli";
			if (["_diver_", typeOf _player] call fn_findString != -1) then {} else 
			{
			_player addVest "V_PlateCarrier3_rgr";
			};
			_player forceAddUniform "U_I_pilotCoveralls";
			_player addWeapon "hgun_Pistol_heavy_01_F";
			// _player addPrimaryWeaponItem "optic_Arco";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			// _player addItemtoBackpack "HandGrenade";
			// _player addItemtoBackpack "HandGrenade";
			// _player addWeapon "";
			_player addHandgunItem "optic_MRD";
			_player addHandgunItem "muzzle_snds_acp";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addItem "Medikit";
			_player addWeapon "Laserdesignator";
			_player linkItem "ItemGPS";
			// _player addItemToBackpack "FirstAidKit";
			// _player addItemToBackpack "FirstAidKit";
			_player addHeadgear "H_PilotHelmetFighter_I";
			_player addItem "NVGoggles";
			// _player addGoggles "G_mas_wpn_wrap_mask_t";			
			_player selectWeapon "hgun_Pistol_heavy_01_F";	
	};
	case 8: // Diver
	{

			_player addBackpack "B_Carryall_oli";
			if (["_diver_", typeOf _player] call fn_findString != -1) then {} else 
			{
			_player addVest "V_RebreatherIA";
			};
			_player forceAddUniform "U_I_Wetsuit";
			_player addWeapon "hgun_Pistol_heavy_01_F";
			// _player addPrimaryWeaponItem "optic_Arco";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			// _player addItemtoBackpack "HandGrenade";
			// _player addItemtoBackpack "HandGrenade";
			// _player addWeapon "";
			_player addHandgunItem "optic_MRD";
			_player addHandgunItem "muzzle_snds_acp";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addItem "Medikit";
			_player addWeapon "Laserdesignator";
			_player linkItem "ItemGPS";
			// _player addItemToBackpack "FirstAidKit";
			// _player addItemToBackpack "FirstAidKit";
			// _player addHeadgear "H_PilotHelmetFighter_I";
			_player addItem "NVGoggles";
			// _player addGoggles "G_mas_wpn_wrap_mask_t";			
			_player selectWeapon "hgun_Pistol_heavy_01_F";	
	};
	case 9: // Admin
	{
			_player addBackpack "B_Carryall_oli";
			if (["_diver_", typeOf _player] call fn_findString != -1) then {} else 
			{
			_player addVest "V_PlateCarrier3_rgr";
			};
			_player forceAddUniform "U_B_Protagonist_VR";
			_player addWeapon "hgun_Pistol_heavy_01_F";
			// _player addPrimaryWeaponItem "optic_Arco";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			// _player addItemtoBackpack "HandGrenade";
			// _player addItemtoBackpack "HandGrenade";
			// _player addWeapon "";
			_player addHandgunItem "optic_MRD";
			_player addHandgunItem "muzzle_snds_acp";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addMagazine "11Rnd_45ACP_Mag";
			_player addItem "Medikit";
			_player addWeapon "Laserdesignator";
			_player linkItem "ItemGPS";
			// _player addItemToBackpack "FirstAidKit";
			// _player addItemToBackpack "FirstAidKit";
			_player addHeadgear "H_CrewHelmetHeli_I";
			_player addItem "NVGoggles";
			// _player addGoggles "G_mas_wpn_wrap_mask_t";			
			_player selectWeapon "hgun_Pistol_heavy_01_F";	
	};
	default 
	{
		_player addBackpack "B_AssaultPack_rgr";
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addWeapon "hgun_ACPC2_F";
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addMagazine "9Rnd_45ACP_Mag";
		_player addItem "FirstAidKit";
		_player selectWeapon "hgun_ACPC2_F";
	};
	
};

switch (true) do
{
	case (["_medic_", typeOf _player] call fn_findString != -1):
	{
		_player removeItem "FirstAidKit";
		_player addItem "Medikit";
	};
	case (["_engineer_", typeOf _player] call fn_findString != -1):
	{
		_player addItem "MineDetector";
		_player addItem "Toolkit";
	};
	case (["_sniper_", typeOf _player] call fn_findString != -1):
	{
		_player addWeapon "Rangefinder";
	};
};



if (_player == player) then
{
	thirstLevel = 100;
	hungerLevel = 100;
};
