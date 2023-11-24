function aud_stim_weight = get_auditory_weight(handles2give)
%GET_AUDITORY_WEIGHT Get sum of total whisker stimulus weights.

if handles2give.aud_stim_amp_range
    aud_stim_weight = handles2give.aud_stim_weight_1+...
    handles2give.aud_stim_weight_2+...
    handles2give.aud_stim_weight_3+...
    handles2give.aud_stim_weight_4;

else
    aud_stim_weight = handles2give.aud_stim_weight_1;
end

end
