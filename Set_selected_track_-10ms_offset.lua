
-- Set Playback offset of selected track

offset = -1*0.01

function SetPositiveOffset(track,offset)
  if reaper.GetMediaTrackInfo_Value(track,"I_PLAY_OFFSET_FLAG") == 1 then
    reaper.SetMediaTrackInfo_Value(track,"I_PLAY_OFFSET_FLAG",0)
  end
  reaper.SetMediaTrackInfo_Value(track,"D_PLAY_OFFSET",offset)
end


track = reaper.GetSelectedTrack( 0, 0 )
SetPositiveOffset(track,offset)
