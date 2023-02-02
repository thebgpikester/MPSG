# MULTI PLAYER SLOT GUARD, by Pikes, February 2023

# DESCRIPTION
This is a DCS World script for blocking players spawning in enemy airfields. It is similar in effect to Simple Slot Block by Ciribob but even simpler.

After running, the script will monitor new players of planes or helicopters to see where they spawn. If they spawn at an airbase that is not of their own coalition they will be moved to spectators slot and a chat message will explain that they do not own the airbase. No configuration needed, no triggers required, no funny naming, no hooks, no addon, no mod, and above all, runs from the Mission environment.

# USE CASE
You are an Admin writing a multiplayer mission. You have a server to run a campaign on. You want to spawn client spots in an 'airbase capture game' but realise you cannot due to a DCS limitation. Instead you make the client slots and block them until you own the airbase. You saw SSB and in comparison this sounded easier to implement because there is zero config required and no hooks or mods, its just a script.

# USAGE
Requires MOOSE.lua run first. Download here: https://github.com/FlightControl-Master/MOOSE_INCLUDE/tree/master/Moose_Include_Static
Download mpsg.lua from here (or copy and paste it)
From the Mission Editor in DCS, create a new trigger action on mission start and an action "DO SCRIPT FILE" and point to the moose.lua. Then secondly repeat this process and point to mpsg.lua. Or if you copied the code, use a "DO SCRIPT" action instead. Or run any other way you like if you know what you are doing.
The only configuration in the script is:
MPSGFriendlyMax=3000 --this number is the maximum number of metres away from the nearest friendly airbase a ground start plane can be before it is decided it will be returned to spectators for being too far. Typically 2500 is a normal airfield circle. > 3000 suggests its not near enough to its nearest friendly airbase. I left this configurable in cases of weird ground start locations between two close airfields like Ushaia, Krasnodar.

# LIMITATIONS
The script does nothing if run from ME in single player. The script must have access to the server net environment which is only accessible if launched as a multiplayer server (doesn't matter if its dedicated or a fat server with UI). For testing, it won't cause harm in single player but also won't do anything.

CANNOT KICK THE HOST!!! Currently DCS will crash if the server host is sent to spectators from a slot. This script won't try, and instead you get a cheeky message for not reading this if you try to play as the server host and pick the wrong slot!! Implementing this might be possible with different techniques, however if you are running a server and also playing it at the same time, do yourself a favor and install a local copy of DCS Dedicated server for free, with a smaller size, as it will use a different processor core and your friends will have a smoother time. And you can use this then.

Neutral airfields are not considered when determining if the player should be allowed to spawn. The reason for this is it would allow both enemy and friend to spawn at the same location without the check, and that would be silly. Since it only works in Multiplayer, there is no single player usage considered. Contested airfields (by definition they have both coalitions inside the 2.5km black circular boundary) are not managed. The airfield must be your own. You can check on F10 map by clicking who owns it. Works for both sides, planes and helicopters on all types of ground starts, not air starts. Does not affect AI.

# FAQ
-- Why, when there is SSB?
There was no reason to rewrite SSB around DCS 1.5 times until in late 2021 ED added some of the net environment functions to be accessible to the Mission environment. Even then, there's a tiny fraction of people who run MP servers and don't put a lot of effort in or need something more. The use case is that the admin is happy with the default blocking setting of "by coalition", they dont want to edit a trigger per plane, don't need to reserve squad tags, perform kicking or banning and just want a zero effort/config install. I also have to admit it was me who couldn't be bothered to setup SSB. SSB requires a hook, script and triggers names per slot which takes effort to setup especially if you add lots of slots. The most obvious use case was easier to make a script for, just kick anything thats spawned at a airbase that isn't your own. BAM. The code then becomes very simple.

-- I don't like the name.
Firstly, thats not a question. :D Secondly, neither do I, but 'Even Simpler Slot Blocker' is cheeky and Ciribob is my personal DCS scripting hero.

-- Will you expand on the features?
If enough people will benefit or I specifically like them myself, maybe. Drop an Issue in, above. No promises.

-- Sharing etc
Sure. I'd ask if you used this that you spent the same time helping someone else or being nice to your close family. What goes around, comes around. Keep it moving.
<3

