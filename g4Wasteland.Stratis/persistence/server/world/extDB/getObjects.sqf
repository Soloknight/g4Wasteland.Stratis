// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: getObjects.sqf
//	@file Author: AgentRev

private ["_maxLifetime", "_saveUnlockedObjects", "_vars", "_columns", "_result", "_objects", "_objData"];

_maxLifetime = ["A3W_objectLifetime", 0] call getPublicVar;  // 0
_maxUnusedtime = ["A3W_objectMaxUnusedTime",0] call getPublicVar;  // 5*24
_saveUnlockedObjects = ["A3W_extDB_SaveUnlockedObjects", 0] call getPublicVar;  // 1

if ((_maxLifetime > 0) || (_maxUnusedtime > 0) || (_saveUnlockedObjects <= 0)) then
{
	[format ["deleteExpiredServerObjects:%1:%2:%3:%4", call A3W_extDB_ServerID, call A3W_extDB_MapID, _maxUnusedtime, _saveUnlockedObjects], 2] call extDB_Database_async;
};

// DB column name, oLoad variable name
_vars =
[
	["ID", "_objectID"],
	["Class", "_class"],
	["Position", "_pos"],
	["Direction", "_dir"],
	["Locked", "_locked"],
	["Damage", "_damage"],
	["AllowDamage", "_allowDamage"],
	["Variables", "_variables"],
	["Weapons", "_weapons"],
	["Magazines", "_magazines"],
	["Items", "_items"],
	["Backpacks", "_backpacks"],
	["TurretMagazines", "_turretMags"],
	["AmmoCargo", "_ammoCargo"],
	["FuelCargo", "_fuelCargo"],
	["RepairCargo", "_repairCargo"]
];

_columns = "";

{
	_columns = _columns + ((if (_columns != "") then { "," } else { "" }) + (_x select 0));
} forEach _vars;

_result = [format ["getServerObjects:%1:%2:%3", call A3W_extDB_ServerID, call A3W_extDB_MapID, _columns], 2, true] call extDB_Database_async;

_objects = [];

{
	_objData = [];
	{
		if (!isNil "_x") then
		{
			_objData pushBack [(_vars select _forEachIndex) select 1, _x];
		};
	} forEach _x;

	_objects pushBack _objData;
} forEach _result;

_objects
