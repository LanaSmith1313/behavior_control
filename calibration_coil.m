%% Define daq session.

session = daq.createSession('ni');
session_sampling_rate = 100000;
session.Rate = session_sampling_rate;

% Send coil impulse to amplifier.
addAnalogOutputChannel(session,'Dev1','ao1', 'Voltage');
% channel_coil = addAnalogOutputChannel(session,'PXI1Slot2','ao0', 'Voltage');

% Read teslameter or displacement sensor output.
addAnalogInputChannel(session,'Dev1','ai2', 'Voltage');

%% Define coil impulses.

sr = session_sampling_rate/1000;  % Sampling rate in ms.
baseline_dur = 2000;
trial_dur = 4000;

% Blank stimulus.

blank = zeros(1,trial_dur*sr);

% Biphasic square pulse 1 ms 35 mT.

stim_amp = 3.3;
stim_duration = 1;
scale_factor = .95;

stim_duration_up = stim_duration/2*sr+6;
stim_duration_down = stim_duration/2*sr+1;

biphasic_square_35 = stim_amp*[zeros(1,baseline_dur*sr) ones(1,stim_duration_up) -ones(1,stim_duration_down)*scale_factor];
biphasic_square_35 = [biphasic_square_35 zeros(1,trial_dur*sr-numel(biphasic_square_35))];


% Biphasic square pulse 1 ms 30 mT.

stim_amp = 2.8;
stim_duration = 1;
scale_factor = .95;

stim_duration_up = stim_duration/2*sr+6;
stim_duration_down = stim_duration/2*sr+1;

biphasic_square_30 = stim_amp*[zeros(1,baseline_dur*sr) ones(1,stim_duration_up) -ones(1,stim_duration_down)*scale_factor];
biphasic_square_30 = [biphasic_square_30 zeros(1,trial_dur*sr-numel(biphasic_square_30))];


% Biphasic Hann window 1.6 ms 35 mT.

stim_amp = 4;
stim_duration_up = 1;
stim_duration_down = .6;
scale_factor = 1.85;

stim_duration_up = stim_duration_up*sr;
stim_duration_down = stim_duration_down*sr;

impulse_up = tukeywin(stim_duration_up,1);
impulse_up = impulse_up(1:end-1);
impulse_down = -tukeywin(stim_duration_down,1);
impulse_down = impulse_down(2:end);
impulse = [impulse_up' scale_factor*impulse_down'];

biphasic_hann_35 = stim_amp * [zeros(1,baseline_dur*sr) impulse];
biphasic_hann_35 = [biphasic_hann_35 zeros(1,trial_dur*sr - numel(biphasic_hann_35))];


% Biphasic Hann window 1.6 ms 30 mT.

stim_amp = 3.2;
stim_duration_up = 1;
stim_duration_down = .6;
scale_factor = 1.6;

stim_duration_up = stim_duration_up*sr;
stim_duration_down = stim_duration_down*sr;

impulse_up = tukeywin(stim_duration_up,1);
impulse_up = impulse_up(1:end-1);
impulse_down = -tukeywin(stim_duration_down,1);
impulse_down = impulse_down(2:end);
impulse = [impulse_up' scale_factor*impulse_down'];

biphasic_hann_30 = stim_amp * [zeros(1,baseline_dur*sr) impulse];
biphasic_hann_30 = [biphasic_hann_30 zeros(1,trial_dur*sr - numel(biphasic_hann_30))];

% Biphasic Hann window 1.6 ms 25 mT.

stim_amp = 2.4;
stim_duration_up = 1;
stim_duration_down = .6;
scale_factor = 1.3;

stim_duration_up = stim_duration_up*sr;
stim_duration_down = stim_duration_down*sr;

impulse_up = tukeywin(stim_duration_up,1);
impulse_up = impulse_up(1:end-1);
impulse_down = -tukeywin(stim_duration_down,1);
impulse_down = impulse_down(2:end);
impulse = [impulse_up' scale_factor*impulse_down'];

biphasic_hann_25 = stim_amp * [zeros(1,baseline_dur*sr) impulse];
biphasic_hann_25 = [biphasic_hann_25 zeros(1,trial_dur*sr - numel(biphasic_hann_25))];


% Biphasic Hann window 1.6 ms 20 mT.

stim_amp = 2.2;
stim_duration_up = 1;
stim_duration_down = .6;
scale_factor = 1.3;

stim_duration_up = stim_duration_up*sr;
stim_duration_down = stim_duration_down*sr;

impulse_up = tukeywin(stim_duration_up,1);
impulse_up = impulse_up(1:end-1);
impulse_down = -tukeywin(stim_duration_down,1);
impulse_down = impulse_down(2:end);
impulse = [impulse_up' scale_factor*impulse_down'];

biphasic_hann_20 = stim_amp * [zeros(1,baseline_dur*sr) impulse];
biphasic_hann_20 = [biphasic_hann_20 zeros(1,trial_dur*sr - numel(biphasic_hann_20))];

% Biphasic Hann window 1.6 ms 15 mT.

stim_amp = 1.7;
stim_duration_up = 1;
stim_duration_down = .6;
scale_factor = 1.25;

stim_duration_up = stim_duration_up*sr;
stim_duration_down = stim_duration_down*sr;

impulse_up = tukeywin(stim_duration_up,1);
impulse_up = impulse_up(1:end-1);
impulse_down = -tukeywin(stim_duration_down,1);
impulse_down = impulse_down(2:end);
impulse = [impulse_up' scale_factor*impulse_down'];

biphasic_hann_15 = stim_amp * [zeros(1,baseline_dur*sr) impulse];
biphasic_hann_15 = [biphasic_hann_15 zeros(1,trial_dur*sr - numel(biphasic_hann_15))];


% Biphasic Hann window 3 ms 35 mT.

stim_amp = 2.85;
stim_duration_up = 1.5;
stim_duration_down = 1.5;
scale_factor = .6;

stim_duration_up = stim_duration_up*sr;
stim_duration_down = stim_duration_down*sr-5;

impulse_up = tukeywin(stim_duration_up,1);
impulse_up = impulse_up(1:end-1);
impulse_down = -tukeywin(stim_duration_down,1);
impulse_down = impulse_down(2:end);
impulse = [impulse_up' scale_factor*impulse_down'];

biphasic_hann_3ms_35 = stim_amp * [zeros(1,baseline_dur*sr) impulse];
biphasic_hann_3ms_35 = [biphasic_hann_3ms_35 zeros(1,trial_dur*sr - numel(biphasic_hann_3ms_35))];

% Biphasic Hann window 3 ms 30 mT.

stim_amp = 2.3;
stim_duration_up = 1.5;
stim_duration_down = 1.5;
scale_factor = .6;

stim_duration_up = stim_duration_up*sr;
stim_duration_down = stim_duration_down*sr;

impulse_up = tukeywin(stim_duration_up,1);
impulse_up = impulse_up(1:end-1);
impulse_down = -tukeywin(stim_duration_down,1);
impulse_down = impulse_down(2:end);
impulse = [impulse_up' scale_factor*impulse_down'];

biphasic_hann_3ms_30 = stim_amp * [zeros(1,baseline_dur*sr) impulse];
biphasic_hann_3ms_30 = [biphasic_hann_3ms_30 zeros(1,trial_dur*sr - numel(biphasic_hann_3ms_30))];



% Biphasic Hann window 3 ms 25 mT.

stim_amp = 1.95;
stim_duration_up = 1.5;
stim_duration_down = 1.5;
scale_factor = .6;

stim_duration_up = stim_duration_up*sr;
stim_duration_down = stim_duration_down*sr;

impulse_up = tukeywin(stim_duration_up,1);
impulse_up = impulse_up(1:end-1);
impulse_down = -tukeywin(stim_duration_down,1);
impulse_down = impulse_down(2:end);
impulse = [impulse_up' scale_factor*impulse_down'];

biphasic_hann_3ms_25 = stim_amp * [zeros(1,baseline_dur*sr) impulse];
biphasic_hann_3ms_25 = [biphasic_hann_3ms_25 zeros(1,trial_dur*sr - numel(biphasic_hann_3ms_25))];



% Biphasic Hann window 3 ms 20 mT.

stim_amp = 1.5;
stim_duration_up = 1.5;
stim_duration_down = 1.5;
scale_factor = .6;

stim_duration_up = stim_duration_up*sr;
stim_duration_down = stim_duration_down*sr;

impulse_up = tukeywin(stim_duration_up,1);
impulse_up = impulse_up(1:end-1);
impulse_down = -tukeywin(stim_duration_down,1);
impulse_down = impulse_down(2:end);
impulse = [impulse_up' scale_factor*impulse_down'];

biphasic_hann_3ms_20 = stim_amp * [zeros(1,baseline_dur*sr) impulse];
biphasic_hann_3ms_20 = [biphasic_hann_3ms_20 zeros(1,trial_dur*sr - numel(biphasic_hann_3ms_20))];


% Biphasic Hann window 3 ms 15 mT.

stim_amp = 1.2;
stim_duration_up = 1.5;
stim_duration_down = 1.5;
scale_factor = .6;

stim_duration_up = stim_duration_up*sr;
stim_duration_down = stim_duration_down*sr;

impulse_up = tukeywin(stim_duration_up,1);
impulse_up = impulse_up(1:end-1);
impulse_down = -tukeywin(stim_duration_down,1);
impulse_down = impulse_down(2:end);
impulse = [impulse_up' scale_factor*impulse_down'];

biphasic_hann_3ms_15 = stim_amp * [zeros(1,baseline_dur*sr) impulse];
biphasic_hann_3ms_15 = [biphasic_hann_3ms_15 zeros(1,trial_dur*sr - numel(biphasic_hann_3ms_15))];


% plot(biphasic_hann);
%%

% stim = biphasic_square_30;
% stim = biphasic_hann_15;
stim = biphasic_hann_3ms_15;
% stim = blank;


ntrial = 5;
len = numel(stim);

data = zeros(ntrial,len);

for itrial=1:ntrial
   disp(itrial)
   queueOutputData(session, stim');
   prepare(session);
   d = startForeground(session);
   data(itrial,:) = d(:,1);
   pause(.5);
end

session.stop();

session.release();
disp('Done')
%

time = linspace(0,trial_dur,numel(stim));

figure
ax1 = subplot(2,1,1);
plot(time, stim)
ax2 = subplot(2,1,2);
plot(time,data')
linkaxes([ax1,ax2],'x')

% for itrial=1:ntrial
%     plot(data(itrial,:))
% end

%% Save calibration data.

path_write = 'K:\calibration';
% file = '220731_calibration_coil_fakemouse_biphasic_hann_3ms_15mT.m';
file = '220731_calibration_displacement_fakemouse_biphasic_hann_3ms_15mT.m';
% file = '220731_calibration_sensor_fakemouse_blank_450?m.m';
file = fullfile(path_write, file);
save(file,'data','stim')
disp('Saved')

%%
% 
% t = linspace(-pi,6/4*pi,100000);
% s = cos(t);
% plot(s)

stim_amp = 3;
stim_duration_up = 1;
stim_duration_down = .5;
scale_factor = 1.8;

stim_duration_up = stim_duration_up*sr;
stim_duration_down = stim_duration_down*sr;

s1 = cos(linspace(-pi,0,stim_duration_up/2))/2 + 1/2;
s2 = cos(linspace(0,1/2*pi,stim_duration_up/2));
s3 = cos(linspace(1/2*pi,pi,stim_duration_down/2));
s3 = s3(2:end);
s3 = s3 * scale_factor;
s4 = cos(linspace(pi,2*pi,stim_duration_down/2))/2 - 1/2;
s4 = s4 * scale_factor;

impulse = [s1 s2 s3 s4];
test = stim_amp * [zeros(1,baseline_dur*sr) impulse];
test = [test zeros(1,trial_dur*sr - numel(test))];




