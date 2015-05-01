/* format["Welcome to G4-Gamers. Wasteland"] hintC
[
	"Try different classes from the lobby ( Insurgent, Sniper, Engineer, Diver, Explosive Specialist)",
	"Bought, Mission and Airdrop vehicles automatically save between restarts.",
	"Base objects will save until unlocked or destroyed.",
	"Vehicle repair or re-arm, speak to the vehicle store owner.",
	"Beacons do NOT save!",
	"Have fun and respect other players. Hacking or exploiting will get you banned :)"
	];
	*/
	
sleep 10;
	
_text = "
<t align='center'><t shadow= 1 shadowColor='#000000'><t size='1.2'><t color='#ff0000'>G4-Gamers Wasteland 2.0</t></t>
<t align='center'><img size='6' shadow = 0 image='mapConfig\logo.paa'/></t>
<br />
<t align='center'><t shadow= 1 shadowColor='#000000'>Jump on our Teamspeak and have some fun with us ts.g4-gamers.com</t><br /> 
<br />
<t align='center'><t shadow= 1 shadowColor='#000000'>Bought and Mission vehicles automatically save between restarts</t><br />
<br />
<t align='center'><t shadow= 1 shadowColor='#000000'>Base objects will save until unlocked or destroyed</t><br />
<br />
<t align='center'><t shadow= 1 shadowColor='#000000'>Vehicle repair or re-arm, speak to the vehicle store owner</t><br />
<br />
<t align='center'><t shadow= 1 shadowColor='#000000'>Only 3 Beacons save!</t><br />
<br />
<t align='center'><t shadow= 1 shadowColor='#000000'>Have fun and respect other players. Hacking or exploiting will get you banned</t>
<br />
";

hint parseText format ["<t align='center'>Welcome %2</t><br />%1",_text, name player];
 