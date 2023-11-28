function aud_stim_amp = get_auditory_stim_amp_uniform(handles2give)

    if handles2give.aud_stim_amp_range

        persistent stimuli
        persistent current_index

        aud_stim_amp_list = [handles2give.aud_stim_amp_1;...
            handles2give.aud_stim_amp_2;...
            handles2give.aud_stim_amp_3;...
            handles2give.aud_stim_amp_4];
        aud_stim_weight_list = [handles2give.aud_stim_weight_1;...
            handles2give.aud_stim_weight_2;...
            handles2give.aud_stim_weight_3;...
            handles2give.aud_stim_weight_4];
        
        if isempty(stimuli) || isempty(current_index)

            stimuli = repelem(aud_stim_amp_list, aud_stim_weight_list);
            stimuli = stimuli(randperm(numel(stimuli)));
            current_index = 1;
        end

        if current_index > numel(stimuli)

            stimuli = stimuli(randperm(numel(stimuli)));
            current_index = 1;
        end
    
        aud_stim_amp = stimuli(current_index);
        current_index = current_index + 1;
    
    else

    aud_stim_amp = handles2give.aud_stim_amp_1;

    end

end


