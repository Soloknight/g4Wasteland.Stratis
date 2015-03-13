// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
/*********************************************************#
# @@ScriptName: updateConnectingClients.sqf
# @@Author: Nick 'Bewilderbeest' Ludlam <bewilder@recoil.org>, AgentRev, Munch
# @@Create Date: 2013-09-15 16:26:38
# @@Modify Date: 2015-02-22 by Munch to handle persistent territory data
# @@Function: Updates connecting players with the correct territory colours/brushes
#*********************************************************/

if (!isServer) exitWith {};

// Exit if territories are not set
if (isNil "currentTerritoryDetails" || {count currentTerritoryDetails == 0}) exitWith {};

 private ["_player", "_playerUID", "_playerTeam", "_playerGroup", "_JIP", "_territorySavingOn", "_markers", "_newTerritoryOwners", "_newTerritoryDetails", "_groupCaptures", "_oldMarkerGroups", "_found", 
 "_markerId", "_markerName", "_markerCaptureUIDs", "_markerCapturePlayers", "_markerTeam", "_markerTeam2", "_markerChrono", "_markerTimer", "_markerGroup", "_markerGroupUIDs", "_oldMarkerGroup"];
 
_player = _this select 0;
_playerUID = getPlayerUID _player;
_playerTeam = side _player;
_playerGroup = group _player;
_JIP = _this select 1;
_territorySavingOn = ["A3W_territorySaving"] call isConfigOn;

diag_log format ["[INFO] updateConnectingClients handling request from [Player: %1] [JIP: %2] side=%3 UID=%4", _player, _JIP, _playerTeam, _playerUID];

_markers = [];
_newTerritoryOwners = [];
_newTerritoryDetails = [];
_groupCaptures = [];
_oldMarkerGroups = [];

{
	_found = false;
	_markerId = _x select 0;	// markerID
	_markerName = _x select 1;   // markerName
	_markerCaptureUIDs = _x select 2; // marker capturer's UIDs
	_markerCapturePlayers = _x select 3;
	_markerTeam = _x select 4;	  // ownerTeam
	_markerTeam2 = _markerTeam;
	_markerChrono = _x select 5; 
	_markerTimer = _x select 6;
	_markerGroup = _x select 7;  // ownerGroup
	_markerGroupUIDs = _x select 8; // ownerGroupUIDs
	_oldMarkerGroup = grpNull;
	
	if (!(_markerTeam in [sideUnknown])) then {
		// Special handling for independent's joining ...
		if (!(_markerTeam in [BLUFOR,OPFOR])) then 
		{
			if (!(_playerTeam in [BLUFOR,OPFOR])) then 
			{
				//diag_log format ["[INFO] updateConnectingClients:  %1 held by group %2 with UIDs=%3, capped by UIDs=%4", _markerName, _markerGroup, _markerGroupUIDs, _markerCaptureUIDs];
			
				// assign player group membership to the group owning the territory, if the player appears in the _markerGroupUIDs and _markerGroup isn't null
				if ((_playerUID in _markerGroupUIDs) && {!(_markerGroup isEqualTo grpNull)}) then
				{
					[_player] join _markerGroup;
					_playerGroup = _markerGroup;
					//diag_log format ["[INFO] updateConnectingClients: player %1 UID is in markerGroupUIDs for %2 -> joining player to group %3 (PRI 2 Assign)", _player, _markerName, _markerGroup];
					
					// note: group membership in persistence will get updated on next payroll
					
				} else {
					// 1st priority: player previously capped this territory ... assign group ownership of this territory to his group
					if (_playerUID in _markerCaptureUIDs) then 
					{
						// Indy player previously captured this UID ... assign/re-assign ownership of the marker to this player's group & clear other UIDs
						
						// add the marker to the player's group's "currentTerritories" var
						_groupCaptures = (_playerGroup getVariable ["currentTerritories", []]) + [_markerName];
						_playerGroup setVariable ["currentTerritories", _groupCaptures, true];
						
						// update maps on members of the group previously owning the territory
						["pvar_updateTerritoryMarkers", [_markerGroup, [[_markerName], false, _playerGroup, false]]] call fn_publicVariableAll;
						
						// set the marker's group ownership to the player's group
						_markerGroup = _playerGroup;
						if (!(_playerUID in _markerGroupUIDs)) then 
						{
							// add the player UID to the list of markerGroupUIDs
							_markerGroupUIDs pushBack _playerUID;  
						};
						
						// call fn_saveTerritory to persist the newly changed territory state, if persistence is on
						if (_territorySavingOn) then 
						{
							[_markerId, _markerName, _markerCaptureUIDs, _markerTeam, _markerChrono, _playerGroup, [_playerUID]] call fn_saveTerritory;
							//diag_log format ["[INFO] updateConnectingClients: updated territory persistence data with [%1,%2,%3,%4,%5,%6,%7]",_markerId, _markerName, _markerCaptureUIDs, _markerTeam, _markerChrono, _playerGroup, _markerGroupUIDs];
						};

						//diag_log format ["[INFO] updateConnectingClients: player %1 UID is in markerCaptureUIDs for %2 -> assigning marker to playerGroup (%3) (PRI 1 Assign)", _player, _markerName, _markerGroup];
						_found = true;
					} else {
					
						//diag_log format ["[INFO] updateConnectingClients: 2nd test - playerUID ! in markerCaptureIDs (%1) && (playerUID ! in markerGroupIDs (%2) or markerGroup (%3) is null) with found=%4", _markerCaptureUIDs, _markerGroupUIDs, _markerGroup, _found];
						
						if ((_playerUID in _markerGroupUIDs) && {!_found}) then 
						{
						
							//diag_log "[INFO] updateConnectingClients: 2nd test -  Indy player was previously member of a now non-recognized group that still owns this territory";
							
							// Indy player was previously member of a now non-recognized group that still owns this territory ... re-assign group ownership, but keep other UIDs
							_markerGroup = _playerGroup;
							
							// add the marker to the player's group's "currentTerritories" var
							_groupCaptures = (_playerGroup getVariable ["currentTerritories", []]) + [_markerName];
							_playerGroup setVariable ["currentTerritories", _groupCaptures, true];

							// call fn_saveTerritory to persist the newly changed territory state, if persistence is on
							if (_territorySavingOn) then 
							{
								[_markerId, _markerName, _markerCaptureUIDs, _markerTeam, _markerChrono, _playerGroup, _markerGroupUIDs] call fn_saveTerritory;
								//diag_log format ["[INFO] updateConnectingClients: updated territory persistence data with [%1,%2,%3,%4,%5,%6,%7]",_markerId, _markerName, _markerCaptureUIDs, _markerTeam, _markerChrono, _playerGroup, _playerUID];
							};
							
							//diag_log format ["[INFO] updateConnectingClients: player '%1' UID is in markerGroupUIDs for %2 for null group -> assigning marker to player's group (%3) (PRI 3 Assign)", _player, _markerName, _markerGroup];
						}
					};
				};
				
				//diag_log format ["[INFO] updateConnectingClients:  playerGroup 'currentTerritories' = %1", (_playerGroup getVariable ["currentTerritories", []])];
			}; 
			_markerTeam2 = _markerGroup;  // assign group to team2 for Indy's
		};
		
		// add to the array to be sent to the connecting client
		_markers pushBack [_markerName, _markerTeam, _markerGroup];
	}; 
	
	_newTerritoryDetails pushBack [_markerId, _markerName, _markerCaptureUIDs, _markerCapturePlayers, _markerTeam, _markerChrono, _markerTimer, _markerGroup, _markerGroupUIDs];
	_newTerritoryOwners pushBack [_markerName, _markerTeam2];	// territory/team|group
	
	if (!(_oldMarkerGroup in _oldMarkerGroups)) then
	{
		_oldMarkerGroups = _oldMarkerGroups + [_oldMarkerGroup];
	};
	
} forEach currentTerritoryDetails;
	
if !(A3W_currentTerritoryOwners isEqualTo _newTerritoryOwners) then
{
	// update the scoreboard var if any assignment changes happened
	A3W_currentTerritoryOwners = _newTerritoryOwners;
	publicVariable "A3W_currentTerritoryOwners";
};	

if !(currentTerritoryDetails isEqualTo _newTerritoryDetails) then
{
	if (monitorTerritoriesActive) then {
		diag_log text "[INFO] updateConnectingClients wait on monitorTerritories to go inactive";
		waitUntil {!monitorTerritoriesActive};
		diag_log text "INFO] updateConnectingClients resume";
	};
	// update currentTerritoryDetails if any parts of it changed
	currentTerritoryDetails = _newTerritoryDetails;
	//diag_log text "[INFO] updateConnectingClients: updated currentTerritoryDetails array";
};

if (_JIP) then 
{
	// exec updateTerritoryMarkers on the client passing the _markers array to loop over with ownerCheck set to true
	[[[_markers, true], "territory\client\updateTerritoryMarkers.sqf"], "BIS_fnc_execVM", _player, false] call BIS_fnc_MP;
} else {
	// return the result to local caller to return back to the client as a targeted pvar for use on the client
	[_markers, true]
};

