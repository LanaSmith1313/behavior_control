function aud_stim_amp = get_auditory_stim_amp(handles2give)
%GET_AUDITORY_STIM_AMP Get auditory amplitude, in Volt, to use for current
%trial, for unique stimulus amplitude and in the case with a range of
%amplitudes.

if handles2give.aud_stim_amp_range

    % Get whisker amplitudes and weights
    aud_stim_amp_list = [handles2give.aud_stim_amp_1; handles2give.aud_stim_amp_2; handles2give.aud_stim_amp_3; handles2give.aud_stim_amp_4];
    aud_stim_weight_total = get_auditory_weight(handles2give);
    aud_stim_proba_weights = [
        handles2give.aud_stim_weight_1/aud_stim_weight_total; ...
        handles2give.aud_stim_weight_2/aud_stim_weight_total; ...
        handles2give.aud_stim_weight_3/aud_stim_weight_total; ...
        handles2give.aud_stim_weight_4/aud_stim_weight_total];

    % Select randomly whisker stimulus amplitude
    aud_stim_amp = randsample(aud_stim_amp_list, 1, true, aud_stim_proba_weights);

else
    aud_stim_amp = handles2give.aud_stim_amp_1;
end
