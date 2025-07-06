clearvars
close all

% using measurements from the frame IMU and the right wheel IMU
frame_acc = readmatrix('PROCESSED DATA/straight 46ft/frame acc.csv');
frame_angvel = readmatrix('PROCESSED DATA/straight 46ft/frame angvel.csv');
wheel_acc = readmatrix('PROCESSED DATA/straight 46ft/right acc.csv');
wheel_angvel = readmatrix('PROCESSED DATA/straight 46ft/right angvel.csv');

% computing the sampling frequency
frame_time = frame_acc(:,1);
dt_frame = mean(diff(frame_time));
fs_frame = 1/dt_frame; % sampling frequency in Hz

wheel_time = wheel_acc(:,1);
dt_wheel = mean(diff(wheel_time));
fs_wheel = 1/dt_wheel;

% 2nd order Butterworth bidirectional lowpass filter with a cut-off frequency of 5 Hz
fc = 5; % cutoff frequency in Hz

Wn_frame = fc / (fs_frame / 2); % normalize cutoff frequency, where 1 is half sample rate
[bf, af] = butter(2, Wn_frame, 'low'); % designing butterworth filter
filtered_frame_acc = filtfilt(bf,af,frame_acc(:,2:4));
filtered_frame_angvel = filtfilt(bf,af,frame_angvel(:,2:4));

Wn_wheel = fc / (fs_wheel / 2);
[bw, aw] = butter(2, Wn_wheel, 'low'); % designing butterworth filter
filtered_wheel_acc = filtfilt(bw,aw,wheel_acc(:,2:4));
filtered_wheel_angvel = filtfilt(bw,aw,wheel_angvel(:,2:4));

grav_unit = [  -0.107217447120385   0.985808811775816   0.129172000286986]; % found empirically in empirical_grav.m
% aligning IMU's frame of reference with gravity
yaxis = [0 1 0];
axis_angle = vrrotvec(grav_unit, yaxis); % calculating rotation needed to transform the empirical gravity to the y-axis (IMU grav reference direction)
R = vrrotvec2mat(axis_angle); % creating rotation matrix for the rotation needed
% rotating the acceleration vector of frame row-wise
frame_acc_aligned = (R * filtered_frame_acc')';
frame_angvel_aligned = (R * filtered_frame_angvel')';

% aligning wheel IMU with rotation axis (z)
% extracting 10s of straight wheel rotation
wheel_10s_start_index = find(wheel_time >= 6,1);
wheel_10s_end_index = find(wheel_time >= 16,1);
wheel_data10 = filtered_wheel_angvel(wheel_10s_start_index:wheel_10s_end_index,:);
wheel_data10 = [wheel_time(wheel_10s_start_index:wheel_10s_end_index), wheel_data10];
avgrot_wheel_axis = mean(wheel_data10(:,2:4)); %vector of wheel axis in IMU frame of reference
wheel_axis_unit = avgrot_wheel_axis / norm(avgrot_wheel_axis); % normalized

% Compute total angular velocity magnitude
IMU_AV_tot = vecnorm(filtered_wheel_angvel, 2, 2);

% Project angular velocity onto wheel axis
dot_products = filtered_wheel_angvel * wheel_axis_unit';
cos_alpha = dot_products ./ IMU_AV_tot;
cos_alpha(IMU_AV_tot == 0) = 0;
IMU_AV_axis = cos_alpha .* IMU_AV_tot; % angular velocity around wheel axis

% COMPUTING TOTAL DISTANCE
wheel_angular_displacement = cumtrapz(wheel_time, IMU_AV_axis); % angular displacement over time by integrating angular velocity
wheel_distance = wheel_angular_displacement * 0.3048;  % linear distance in meters
wheel_distance_ft = wheel_distance * 3.28084; % linear distance in ft
total_distance_ft = wheel_distance_ft(end)

figure;
plot(wheel_time, wheel_distance_ft, 'LineWidth', 2);
xlabel('Time (seconds)');
ylabel('Distance covered (feet)');
title('Wheel distance over time');
grid on;
