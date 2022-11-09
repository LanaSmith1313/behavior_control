function main_control(~,event)
% MAIN_CONTROL Defines main control commands for the behaviour (lick, detection, stimuli delivery, ...)
% EVENT

    global Main_S Stim_S Reward_S LickTime Quietwindow Trial_Duration ITI  ...
         LickEarlyAlreadyDetected ArtifactWindow StimAmp...
        ReactionTime  Aud_vec Aud_Rew Wh_Rew Wh_vec Wh_NoWh Aud_NoAud AStimDuration AStimAmp AStimFreq  TrialTime ...
         TrialFinished StimBoolian  Association...
        TimeOutEarlyLick TimeOut Trigger_S EarlyLick TrialStarted RewardTime ...
        RewardSound_vec RewardSound folder_name Fs_Reward Stim_NoStim Light_PreStim...
        Lick_Threshold handles2give ResponseWindowStart fid3 lh3 ResponseWindowEnd StimDuration...
        BaselineWindow RewardShouldBeDelivered EarlylickCounter trial_number...
        fid1 Light_NoLight  HitTime AnimalLicked  SITrigger_vec...
        PerformanceAndSaveBoolian SessionStart Time Main_S_SR RewardDelivered...
        UpdateParametersBoolean Stim_S_SR Camera_vec Reward_NoReward Light_Duration Light_Freq Light_Amp TrialLickData...


    % Read data of Main_S
    [data_main, timestamps, trigger_time] = read(Main_S, Main_S.ScansAvailableFcnCount,'OutputFormat','Matrix');
    % Timing last lick detection for quiet window.
    % --------------------------------------------

    % A lick is defined as a single scan crossing the lick threshold.
    %if sum( abs(event.Data(1:end-1,1)) < Lick_Threshold & abs(event.Data(2:end,1)) > Lick_Threshold )
    %    LickTime=tic;
    %end
    
     if sum(abs(data_main(1:end-1,1)) < Lick_Threshold & abs(data_main(2:end,1)) > Lick_Threshold )
        LickTime=tic;
    end


    %% Stimulus delivery.
    %% ------------------

    if  StimBoolian && toc(LickTime) > Quietwindow/1000 && toc(TrialFinished) > ITI/1000 &&...
            toc(TimeOut) > TimeOutEarlyLick/1000
        size(event.Data)

        StimBoolian=0;
        set(handles2give.OnlineTextTag,'String','Trial Started','FontWeight','bold');
        TrialTime=tic;

        outputSingleScan(Trigger_S,[1 0 0])

        % Free reward.
        if Association && Stim_NoStim
            RewardShouldBeDelivered=1;
        end

        LickEarlyAlreadyDetected=0;
        TrialStarted=1;
        PerformanceAndSaveBoolian=0;
        AnimalLicked=0;
        Time=toc(SessionStart);
    end


    % Detecting rewarded licks and trigger reward.
    % --------------------------------------------

    if TrialStarted && ~Association  && ...
        toc(TrialTime)>ResponseWindowStart && toc(TrialTime)<ResponseWindowEnd &&...
        sum(abs(event.Data(1:end-1,1))<Lick_Threshold & abs(event.Data(2:end,1))>Lick_Threshold) &&...
        ~sum(abs(event.Data(1:end-1,1))<10000*Lick_Threshold & abs(event.Data(2:end,1))>10000*Lick_Threshold)

        TrialStarted=0;

        if Aud_Rew && ~Wh_Rew
            if Aud_NoAud
                HitTime=toc(TrialTime);
                reward_delivery %deliver reward
                FirstThresholdCross=find(abs(event.Data(1:end-1,1))<Lick_Threshold & abs(event.Data(2:end,1))>Lick_Threshold',1,'first');
                HitTimeAdjusted=HitTime-FirstThresholdCross/Main_S_SR;
                ReactionTime=HitTimeAdjusted-(BaselineWindow)/1000;
                AnimalLicked=1;
                PerformanceAndSaveBoolian=1;
            elseif Wh_NoWh
                HitTime=toc(TrialTime);
                FirstThresholdCross=find(abs(event.Data(1:end-1,1))<Lick_Threshold & abs(event.Data(2:end,1))>Lick_Threshold',1,'first');
                pause(5); %timeout for FA
                HitTimeAdjusted=HitTime-FirstThresholdCross/Main_S_SR;
                ReactionTime=HitTimeAdjusted-(BaselineWindow)/1000;
                AnimalLicked=1;
                PerformanceAndSaveBoolian=1;
            else
                HitTime=toc(TrialTime);
                FirstThresholdCross=find(abs(event.Data(1:end-1,1))<Lick_Threshold & abs(event.Data(2:end,1))>Lick_Threshold',1,'first');
                pause(5); %timeout for FA
                HitTimeAdjusted=HitTime-FirstThresholdCross/Main_S_SR;
                ReactionTime=HitTimeAdjusted-(BaselineWindow)/1000;
                AnimalLicked=1;
                PerformanceAndSaveBoolian=1;
            end
        elseif ~Aud_Rew && Wh_Rew
            if Aud_NoAud
                HitTime=toc(TrialTime);
                FirstThresholdCross=find(abs(event.Data(1:end-1,1))<Lick_Threshold & abs(event.Data(2:end,1))>Lick_Threshold',1,'first');
                pause(5) %timeout for FA
                HitTimeAdjusted=HitTime-FirstThresholdCross/Main_S_SR;
                ReactionTime=HitTimeAdjusted-(BaselineWindow)/1000;
                AnimalLicked=1;
                PerformanceAndSaveBoolian=1;

            elseif Wh_NoWh
                HitTime=toc(TrialTime);
                reward_delivery
                FirstThresholdCross=find(abs(event.Data(1:end-1,1))<Lick_Threshold & abs(event.Data(2:end,1))>Lick_Threshold',1,'first');
                HitTimeAdjusted=HitTime-FirstThresholdCross/Main_S_SR;
                ReactionTime=HitTimeAdjusted-(BaselineWindow)/1000;
                AnimalLicked=1;
                PerformanceAndSaveBoolian=1;
            else
                HitTime=toc(TrialTime);
                FirstThresholdCross=find(abs(event.Data(1:end-1,1))<Lick_Threshold & abs(event.Data(2:end,1))>Lick_Threshold',1,'first');
                pause(5); %timeout for FA
                HitTimeAdjusted=HitTime-FirstThresholdCross/Main_S_SR;
                ReactionTime=HitTimeAdjusted-(BaselineWindow)/1000;
                AnimalLicked=1;
                PerformanceAndSaveBoolian=1;
            end
        elseif Aud_Rew && Wh_Rew
            HitTime=toc(TrialTime);
            reward_delivery
            FirstThresholdCross=find(abs(event.Data(1:end-1,1))<Lick_Threshold & abs(event.Data(2:end,1))>Lick_Threshold',1,'first');
            HitTimeAdjusted=HitTime-FirstThresholdCross/Main_S_SR;
            ReactionTime=HitTimeAdjusted-(BaselineWindow)/1000;
            AnimalLicked=1;
            PerformanceAndSaveBoolian=1;
        end
    end

    % Setting booleans if lick was not detected within the response window
    if  ~Association && TrialStarted && toc(TrialTime)>ResponseWindowEnd+0.3 %0.3 because...?
        TrialStarted=0;
        PerformanceAndSaveBoolian=1;
    end


    % Defining Performance (perf) and Saving Session Results Data

    if PerformanceAndSaveBoolian
        PerformanceAndSaveBoolian=0;
        if Association
            set(handles2give.OnlineTextTag,'String','Trial Finished','FontWeight','bold');
            Lick=0;
            perf=6; % 6 for All in association
        else
            if Stim_NoStim==1 && AnimalLicked==0 && Wh_NoWh
                set(handles2give.OnlineTextTag,'String','WMiss','FontWeight','bold');
                Lick=0;
                perf=0;
                EarlyLick = 0;

            elseif Stim_NoStim==1 && AnimalLicked==0 && Aud_NoAud
                set(handles2give.OnlineTextTag,'String','AMiss','FontWeight','bold');
                Lick=0;
                perf=1;
                EarlyLick = 0;

            elseif Stim_NoStim==1 && AnimalLicked==1 && Wh_NoWh
                set(handles2give.OnlineTextTag,'String','WHit','FontWeight','bold');
                Lick=1;
                perf=2;
                EarlyLick = 0;

            elseif Stim_NoStim==1 && AnimalLicked==1 && Aud_NoAud
                set(handles2give.OnlineTextTag,'String','AHit','FontWeight','bold');
                Lick=1;
                perf=3;
                EarlyLick = 0;

            elseif Stim_NoStim==0 && AnimalLicked==0
                set(handles2give.OnlineTextTag,'String','Correct Rejection','FontWeight','bold');
                Lick=0;
                perf=4;
                EarlyLick = 0;

            elseif Stim_NoStim==0 && AnimalLicked==1
                set(handles2give.OnlineTextTag,'String','False Alarm','FontWeight','bold');
                Lick=1;
                perf=5; %FA catch trials
                EarlyLick = 0;
            end
        end

        % Save as .txt file
        Results = [trial_number StimDuration Quietwindow ITI Association Stim_NoStim Wh_NoWh Aud_NoAud Lick perf Light_NoLight ReactionTime*1000 StimAmp Time Reward_NoReward Aud_Rew Wh_Rew AStimDuration AStimAmp AStimFreq EarlyLick Light_Amp Light_Duration Light_Freq Light_PreStim];
        fprintf(fid1,...
            '%6.0f %14.1f %17.0f %11.0f %9.0f %15.0f %15.0f %12.0f %8.0f %8.0f %15.0f %15.1f %13.2f %10.0f %14.0f %15.0f %15.0f %15.1f %15.1f %15.1f %15.1f %15.1f %15.1f %15.1f %15.1f \n',...
            Results);
        TrialFinished=tic;
        UpdateParametersBoolean=1;

    end

    % if UpdateParametersBoolean && Stim_S.ScansQueued==0  && Stim_S.ScansAcquired==ScansTobeAcquired && Stim_S.IsDone &&...
    if UpdateParametersBoolean && Stim_S.IsDone &&...
            (~RewardDelivered || Reward_S.ScansQueued==0) && ~handles2give.PauseRequested
        UpdateParametersBoolean=0;
        update_parameters
    elseif UpdateParametersBoolean && Stim_S.IsDone &&...
            (~RewardDelivered || Reward_S.ScansQueued==0) && handles2give.PauseRequested && handles2give.ReportPause
        handles2give.ReportPause=0;
        set(handles2give.OnlineTextTag,'String','Session Paused','FontWeight','bold');
    end

    %% Detecting early licks (licks between cue and stim or between light start and stim)

    if TrialStarted && ~LickEarlyAlreadyDetected...
       && toc(TrialTime)<ResponseWindowStart-(ArtifactWindow)/1000 ...
       && sum(abs(event.Data(1:end-1,1))<Lick_Threshold & abs(event.Data(2:end,1))>Lick_Threshold)

        TimeOut=tic;
        TrialStarted=0;
        LickEarlyAlreadyDetected=1;
        EarlyLick = 1;
        EarlylickCounter=EarlylickCounter+1;
        RewardShouldBeDelivered=0;
        Stim_S.stop();

        outputSingleScan(Trigger_S,[0 0 0]);

        set(handles2give.OnlineTextTag,'String','Early Lick','FontWeight','bold');

        while Stim_S.IsRunning
            continue
        end
        Stim_S.release();


        queueOutputData(Stim_S,[zeros(1,Stim_S_SR/2);zeros(1,Stim_S_SR/2); zeros(1,Stim_S_SR/2); zeros(1,Stim_S_SR/2)]')
%     queueOutputData(Stim_S,[zeros(1,Stim_S_SR/2); zeros(1,Stim_S_SR/2); zeros(1,Stim_S_SR/2)]')
        Stim_S.prepare();
        Stim_S.startBackground();

        Lick = 1;
        perf = 6;


        Results = [trial_number StimDuration Quietwindow ITI Association Stim_NoStim Wh_NoWh Aud_NoAud Lick perf Light_NoLight ReactionTime*1000 StimAmp Time Reward_NoReward Aud_Rew Wh_Rew AStimDuration AStimAmp AStimFreq EarlyLick Light_Amp Light_Duration Light_Freq Light_PreStim] ;
        fprintf(fid1,...
            '%6.0f %14.1f %17.0f %11.0f %9.0f %15.0f %15.0f %12.0f %8.0f %8.0f %15.0f %15.1f %13.2f %10.0f %14.0f %15.0f %15.0f %15.1f %15.1f %15.1f %15.1f %15.1f %15.1f %15.1f %15.1f \n',...
            Results);



    %     EarlyLickDetails = [trial_number Quietwindow ITI TimeOutEarlyLick Association (toc(TrialTime)-toc(LickTime))*1000] ;
    %     fprintf(fid2,'%6.0f %14.0f %11.0f %7.0f %11.0f %17.0f \n',EarlyLickDetails);

        while ~Stim_S.IsRunning
            continue
        end

        outputSingleScan(Trigger_S,[1 0 0]);

        while Stim_S.ScansQueued==0
            continue
        end

        Stim_S.stop();
        Stim_S.release();
        outputSingleScan(Trigger_S,[0 0 0]);

        while Stim_S.IsRunning
            continue
        end


        fclose(fid3);
        delete(lh3);

        trial_number = trial_number + 1;

        CameraFlag = handles2give.CameraFlag;

    %     if CameraFlag
    %         Camera_freq=handles2give.CameraFrameRate; % Hz
    %
    %         VideoFileInfo.trial_number=trial_number;
    %
    %         VideoFileInfo.directory=['F:\Axel\' char(handles2give.MouseName)...
    %             '\' [char(handles2give.MouseName) '_' char(handles2give.Date) '_' char(handles2give.FolderName) '\']];
    %
    %         Block_Duration=300;
    %         VideoFileInfo.nOfFramesToGrab=(Block_Duration+120)*Camera_freq;
    %
    %         save('Z:\TemplateConfigFile\VideoFileInfo','VideoFileInfo');
    %
    %         %ArmCameraNew()
    %     end

        fid3=fopen([folder_name '\LickTrace' num2str(trial_number) '.bin'],'w');
        lh3 = addlistener(Stim_S,'DataAvailable',@(src, event)log_lick_data(src, event,Trial_Duration) );

        TrialLickData=[];

        % queueOutputData(Stim_S,[Wh_vec; Aud_vec;Light_vec;Camera_vec;SITrigger_vec]')
        queueOutputData(Stim_S,[Wh_vec; Aud_vec; Camera_vec;SITrigger_vec]')

        Stim_S.startBackground();

        while ~Stim_S.IsRunning
            continue
        end

        ReactionTime = 0;
        EarlyLick = 0;
        StimBoolian=1;
    end


    %% Rewarding the stimulus trials in Association
    if  TrialStarted && Association && RewardShouldBeDelivered &&...
            toc(TrialTime)>(Light_PreStim +BaselineWindow)/1000

        RewardShouldBeDelivered=0;
        outputSingleScan(Trigger_S,[0 1 0])
        if RewardSound
            sound(RewardSound_vec,Fs_Reward)
        end
        RewardTime=tic;
        RewardDelivered=1;
        outputSingleScan(Trigger_S,[0 0 0]);
        TrialStarted=0;
        PerformanceAndSaveBoolian=1;

    elseif TrialStarted && Association && ~RewardShouldBeDelivered &&...
            toc(TrialTime)>(Light_PreStim + BaselineWindow)/1000
        TrialStarted=0;
        PerformanceAndSaveBoolian=1;
    end

end
