// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Version: 1.0
//@file Name: init.sqf
//@file Author: MercyfulFate
//@file Created: 21/7/2013 16:00
//@file Description: Initialize razorwire
//@file Argument: the path to the directory holding this file.
private ["_path","_ground_type", "_icon", "_unpack", "_pack"];
_path = _this;

MF_ITEMS_RAZOR_WIRE = "razorwire";
MF_ITEMS_RAZOR_WIRE_TYPE = "Land_Razorwire_F";
_ground_type = "Land_Sleeping_bag_brown_folded_F";
_icon = "client\icons\briefcase.paa";

_pack = [_path, "pack.sqf"] call mf_compile;
_unpack = [_path, "unpack.sqf"] call mf_compile;
mf_items_razor_wire_can_pack = [_path, "can_pack.sqf"] call mf_compile;
mf_items_razor_wire_nearest = {
	_razorwire = objNull;
	_razorwires = nearestObjects [player, [MF_ITEMS_RAZOR_WIRE_TYPE], 3];
	if (count _razorwires > 0) then {
		_razorwire = _razorwires select 0;
	};
	_razorwire;
} call mf_compile;

[MF_ITEMS_RAZOR_WIRE, "Razor-wire", _unpack, _ground_type, _icon, 1] call mf_inventory_create;

private ["_label", "_condition", "_action"];
_label = format["<img image='%1' /> Pack up Razor-wire", _icon];
_condition = "'' == [] call mf_items_razor_wire_can_pack_can;";
_action = [_label, _pack, [], 1, true, false, "", _condition];
["Razor-wire-pack", _action] call mf_player_actions_set;

