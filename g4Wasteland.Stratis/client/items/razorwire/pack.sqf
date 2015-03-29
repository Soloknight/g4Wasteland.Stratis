// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Version: 1.0
//@file Name: pack.sqf
//@file Author: MercyfulFate
//@file Created: 23/7/2013 16:00
//@file Description: Pack the nearest razorwire
//@file Argument: [player, player, _action, []] the standard "called by an action" values

#include "mutex.sqf"
#define ANIM "AinvPknlMstpSlayWrflDnon_medic"
#define DURATION 30
#define ERR_TOO_FAR_AWAY "Packing Razor-wire Failed. You moved too far away"
#define ERR_ALREADY_TAKEN "Packing Razor-wire Failed. Someone else beat you to it."
#define ERR_IN_VEHICLE "Packing Razor-wire Failed. You can't do this in a vehicle."
#define ERR_CANCELLED "Packing Razor-wire Cancelled"

private ["_beacon", "_error", "_hasFailed", "_success"];
_razorwire = [] call mf_items_razor_wire_nearest;
_error = [_razorwire] call mf_items_razor_wire_can_pack;
if (_error != "") exitWith {[_error, 5] call mf_notify_client};

_hasFailed = {
	private ["_progress", "_razorwire", "_caller", "_failed", "_text"];
	_progress = _this select 0;
	_razorwire = _this select 1;
	_text = "";
	_failed = true;
	switch (true) do {
		case (!alive player): {}; // player dead, no error msg needed
		case (isNull _razorwire): {_text = ERR_ALREADY_TAKEN}; //someone has already taken it.
		case (vehicle player != player): {_text = ERR_IN_VEHICLE};
		case (player distance _razorwire > 5): {_text = ERR_TOO_FAR_AWAY};
		case (doCancelAction): {doCancelAction = false; _text = ERR_CANCELLED};
		default {
			_text = format["Razor-wire %1%2 Packed", round(_progress*100), "%"];
			_failed = false;
		};
	};
	[_failed, _text];
};

MUTEX_LOCK_OR_FAIL;
_success =  [DURATION, ANIM, _hasFailed, [_razorwire]] call a3w_actions_start;
MUTEX_UNLOCK;

if (_success) then {
	deleteVehicle _razorwire;
	[MF_ITEMS_RAZOR_WIRE, 1] call mf_inventory_add;
	["You successfully packed the Razor-wire", 5] call mf_notify_client;
};
