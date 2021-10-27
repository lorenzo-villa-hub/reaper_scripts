
function GetTrackNumber(track)
  tracknumber = reaper.GetMediaTrackInfo_Value(track, 'IP_TRACKNUMBER')
  return tracknumber - 1
end

function CheckCurrentOffset(track)
  offset= reaper.GetMediaTrackInfo_Value(track, "D_PLAY_OFFSET")
  if offset ~= 0 then
    reaper.ShowConsoleMsg('Track playback offset is not 0')
    return false
  else
    return true
  end
end 


function Main(track,offset_new)
    tracknumber_L = GetTrackNumber(track)
    tracknumber_R = tracknumber_L + 1
    reaper.Main_OnCommand(40062,0) -- Duplicate Tracks
    track_L = track
    track_R = reaper.GetTrack(0,tracknumber_R)
    reaper.SetMediaTrackInfo_Value(track_L,"I_PLAY_OFFSET_FLAG",0)
    reaper.SetMediaTrackInfo_Value(track_L,"D_PLAY_OFFSET",-1*offset_new)
    reaper.SetMediaTrackInfo_Value(track_R,"I_PLAY_OFFSET_FLAG",0)
    reaper.SetMediaTrackInfo_Value(track_R,"D_PLAY_OFFSET",1*offset_new)
end

offset_new = 0.01
track = reaper.GetSelectedTrack( 0, 0 )
if CheckCurrentOffset(track) then
  Main(track,offset_new)
end
