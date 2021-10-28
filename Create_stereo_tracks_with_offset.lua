
function GetTrackIndex(track)
  tracknumber = reaper.GetMediaTrackInfo_Value(track, 'IP_TRACKNUMBER')
  trackidx = tracknumber - 1
  return trackidx
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

function SetOffset(track_L,track_R,offset_new)
    reaper.SetMediaTrackInfo_Value(track_L,"I_PLAY_OFFSET_FLAG",0)
    reaper.SetMediaTrackInfo_Value(track_L,"D_PLAY_OFFSET",-1*offset_new)
    reaper.SetMediaTrackInfo_Value(track_R,"I_PLAY_OFFSET_FLAG",0)
    reaper.SetMediaTrackInfo_Value(track_R,"D_PLAY_OFFSET",1*offset_new)
end

function SetUpTracks(track)
    reaper.Main_OnCommand(40062,0) -- Duplicate Tracks
    trackidx = GetTrackIndex(track)
    tracknumber = trackidx +1 
    track_L = track
    track_R = reaper.GetTrack(0,tracknumber+1)
    reaper.Main_OnCommand(40001,0) --Track: Insert new Track
    track_P = reaper.GetTrack(0,tracknumber+2)
    reaper.SetMediaTrackInfo_Value(track_P,'IP_TRACKNUMBER',tracknumber)
 --   reaper.SetMediaTrackInfo_Value(track_P,"I_FOLDERDEPTH",1)
    reaper.SetMediaTrackInfo_Value(track_L,'IP_TRACKNUMBER',tracknumber+1)
 --   reaper.SetMediaTrackInfo_Value(track_L,"I_FOLDERDEPTH",-1)
    reaper.SetMediaTrackInfo_Value(track_R,'IP_TRACKNUMBER',tracknumber+2)
--    reaper.SetMediaTrackInfo_Value(track_R,"I_FOLDERDEPTH",-1)
    
    return track_P,track_L,track_R
end
    

offset_new = 0.01
track = reaper.GetSelectedTrack( 0, 0 )
if CheckCurrentOffset(track) then
  track_P,track_L,track_R = SetUpTracks(track)
  
end
