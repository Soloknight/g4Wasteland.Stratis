// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//@file Version: 1.0
//@file Name: deploy.sqf
//@file Author: MercyfulFate
//@file Created: 21/7/2013 16:00
//@file Description: Deploy a Spawn Beacon
//@file Argument: [player, player, _action, []] the standard "called by an action" values

#define ANIM "AinvPknlMstpSlayWrflDnon_medic"
#define ERR_CANCELLED "Action Cancelled"
#define ERR_IN_VEHICLE "Action Failed! You can't do this in a vehicle"
#define MAX_SPAWN_BEACONS 3

private ["_hasFailed", "_success","_pos","_uid","_beacon"];
_hasFailed = {
	private ["_progress", "_failed", "_text"];
	_progress = _this select 0;
	_failed = true;
	switch (true) do {
		case (!alive player): {};
		case (doCancelAction) :{doCancelAction = false; _text = ERR_CANCELLED;};
		case (vehicle player != player): {_text = ERR_IN_VEHICLE};
		default {
			_text = format["Spawn Beacon %1%2 Deployed", round(_progress*100), "%"];
			_failed = false;
		};
	};
	[_failed, _text];
};

// Check how many spawn beacons the player already has deployed
_playerBeaconCntr = 0;
_uid = getPlayerUID player;
diag_log format ["Before deploy, pvar_spawn_beacons has %1 items in it", count pvar_spawn_beacons];
{
	
	if (_x getVariable ["ownerUID",""] == _uid) then {
		_playerBeaconCntr = _playerBeaconCntr + 1;
	};
	
	diag_log format ["Spawn beacon %1 has ownerUID=%2 beaconCntr=%3  max=%4",_forEachIndex, _x getVariable ["ownerUID",""], _playerBeaconCntr, MAX_SPAWN_BEACONS];
} forEach pvar_spawn_beacons;

if (_playerBeaconCntr <= MAX_SPAWN_BEACONS) then
{
	_success = [MF_ITEMS_SPAWN_BEACON_DURATION, ANIM, _hasFailed, []] call a3w_actions_start;

	if (_success) then {
		
		// Spawn 2m in front of the player
		_beacon = createVehicle [MF_ITEMS_SPAWN_BEACON_DEPLOYED_TYPE, [player, [0,2,0]] call relativePos, [], 0, "CAN_COLLIDE"];
		_beacon setDir (getDir player + 270);
		_beacon setVariable ["allowDamage", true, true];
		_beacon setVariable ["a3w_spawnBeacon", true, true];
		_beacon setVariable ["R3F_LOG_disabled", true];
		_beacon setVariable ["side", playerSide, true];
		_beacon setVariable ["ownerName", name player, true];
		_beacon setVariable ["ownerUID", _uid, true];
		_beacon setVariable ["packing", false, true];
		_beacon setVariable ["groupOnly", (playerSide == INDEPENDENT), true];
		{
			if (_x getVariable ["ownerUID",""] == _uid) then {
				pvar_spawn_beacons = pvar_spawn_beacons - [_x];
			};
		} forEach pvar_spawn_beacons;

		pvar_spawn_beacons pushBack _beacon;
		publicVariable "pvar_spawn_beacons";
		pvar_manualObjectSave = netId _beacon;
		publicVariableServer "pvar_manualObjectSave";
		["You placed the Spawn Beacon successfully!", 5] call mf_notify_client;
	};
	_success;
} else {
	["You already have the maximum number of spawn beacons deployed.", 5] call mf_notify_client;
	false;
}
