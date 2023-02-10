--MP SLOT GUARD by Pikes 2023
--Only works in Multiplayer server (can be fat host, dedicated, but not launched from ME in non server mode)
--Will not work on the server host. If you attempt to send the server host to spectators it will crash DCS so you get a message instead.
--Only works on clients connected to the server.
--Script will force a player to the neutral spectator slot if they spawn further than this value in metres from the same coalition (friendly) airbase
--A net chat message will inform them to check the F10 map.
--Neutral airbases are ignored, MP games with both coalitions at the same airbase is silly.
--REQUIRES MOOSE.lua
--You can edit this:
MPSGFriendlyMax=3000
--the number above is in metres and checks distance to nearest airfield in case the pilot spawns away from an airfield
function MPSGPlayerId(name)
  local playerList = net.get_player_list()
  for i=1,#playerList do
    local playerName = net.get_name(i)
      if playerName == name then
        return playerList[i]
      end
  end
  return nil
end

Birth = EVENTHANDLER:New()
Birth:HandleEvent( EVENTS.Birth )

function Birth:OnEventBirth( EventData )
  local slotID = nil
  local player = EventData.IniPlayerName
  if player ~= nil or player == '' then
    local slotID = MPSGPlayerId(player)
      if slotID == nil then
        env.info("The MPSG script is not running on a server, slotID cannot be returned.")
      elseif slotID == 1 then --host
          net.send_chat("Server attempted to move itself to spectators")--causes DCS crash
          MESSAGE:New("Do not try to use slot blocking on the server!!",30,"FAILURE",true):ToAll()
      else
          env.info("The player id for this Birth event is: "..slotID)
            if EventData.IniDCSGroupName ~= nil then
              local grp = GROUP:FindByName(EventData.IniDCSGroupName)
              local type = grp:GetCategory() 
                  if type == 0 or 1 then --plane or heli
                    if not grp:InAir() then
                      local coa = EventData.IniCoalition
                      local coord = grp:GetCoordinate()
                      local place = EventData.PlaceName
                        if place == nil or place == '' then
                          --brute forcing location, should rarely happen and skip to easier code
                          local _,dist=coord:GetClosestAirbase(nil, coa)
                            if dist > MPSGFriendlyMax then
                              net.force_player_slot(MPSGPlayerId(player), 0, '')
                              net.send_chat(player.." , you have attempted to use an aircraft at an airbase not owned by your coalition. Check the F10 map.") 
                            end
                        else
                          local ab = world.getAirbases()
                            for i = 1, #ab do
                              if place == (ab[i]):getName() then
                                local Coa = (ab[i]):getCoalition()
                                  if Coa ~= coa then
                                    net.force_player_slot(MPSGPlayerId(player), 0, '')
                                    net.send_chat(player.." , you have attempted to use an aircraft at an airbase not owned by your coalition. Check the F10 map.")
                                  end
                              end 
                            end --end for
                       end --end if place else   
                    end --if notgrp     
                  end --if type
            end --if eventdata
      end --if slotid, elseif else
  end --if player
end --enf function
