// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Version: 1.0
//@file Name: unpack.sqf
//@file Author: MercyfulFate
//@file Created: 21/7/2013 16:00
//@file Description: Unpack a Razor-wire from your inventory

#define ANIM "AinvPknlMstpSlayWrflDnon_medic"
#define DURATION 15
#define ERR_NO_RW "Unpacking Razor-wire Failed. You have not Razor-wire to unpack"
#define ERR_IN_VEHICLE "Unpacking Razor-wire Failed. You can't do this in a vehicle."
#define ERR_CANCELLED "Unpacking Razor-wire Cancelled"

private ["_razorwire", "_error", "_hasFailed", "_success", "_pos"];

if (MF_ITEMS_RAZOR_WIRE call mf_inventory_count <= 0) exitWith {
	[ERR_NO_RW,5] call mf_notify_client;
	false;
};

_hasFailed = {
	private ["_progress", "_failed", "_text"];
	_progress = _this select 0;
	_text = "";
	_failed = true;
	switch (true) do {
		case (!alive player): {}; // player dead, no error msg needed
		case (vehicle player != player): {_text = ERR_IN_VEHICLE};
		case (MF_ITEMS_RAZOR_WIRE call mf_inventory_count <= 0): {_text = ERR_NO_RW};
		case (doCancelAction): {doCancelAction = false; _text = ERR_CANCELLED};
		default {
			_text = format["Razor-wire %1%2 Unpacked", round(_progress*100), "%"];
			_failed = false;
		};
	};
	[_failed, _text];
};

_success =  [DURATION, ANIM, _hasFailed, []] call a3w_actions_start;

if (_success) then {
	_pos = getPosATL player;
	_razorwire = MF_ITEMS_RAZOR_WIRE_TYPE createVehicle _pos;
	_razorwire setPosATL _pos;
	["You successfully unpacked the Razor-wire", 5] call mf_notify_client;
};
_success
