clearvars
close all
clc

frame_data = readmatrix('frame/46ft-acc.txt');
left_data = readmatrix('left wheel/46ft-acc.txt');
right_data = readmatrix('right wheel/46ft-acc.txt');

frame_gdata = readmatrix('frame/46ft-gyro.txt');
left_gdata = readmatrix('left wheel/46ft-gyro.txt');
right_gdata = readmatrix('right wheel/46ft-gyro.txt');

% graphing the real data sets:
figure(1)
hold on
frame_time = (frame_data(:,1) - frame_data(1,1)) / 1000;
frame_acc_x = frame_data(:,2);
frame_acc_y = frame_data(:,3);
frame_acc_z = frame_data(:,4);
plot(frame_time, frame_acc_y);
plot(frame_time, frame_acc_x);
plot(frame_time, frame_acc_z);
legend("y","x","z");
title("frame");
hold off

figure(2)
hold on
left_time = (left_data(:,1) - left_data(1,1)) / 1000;
left_acc_x = left_data(:,2);
left_acc_y = left_data(:,3);
left_acc_z = left_data(:,4);
plot(left_time, left_acc_y);
plot(left_time, left_acc_x);
plot(left_time, left_acc_z);
legend("y","x","z");
title("left");
hold off

figure(3)
hold on
right_time = (right_data(:,1) - right_data(1,1)) / 1000;
right_acc_x = right_data(:,2);
right_acc_y = right_data(:,3);
right_acc_z = right_data(:,4);
plot(right_time, right_acc_y);
plot(right_time, right_acc_x);
plot(right_time, right_acc_z);
legend("y","x","z");
title("right");
hold off


% looking for maximum value (when I picked chair up) and trimming data to
% begin at index of max value
[~, max_index_frame] = max(frame_data(:,3)); % for frame, max value occurs in y-direction
sync_frame_data = frame_data(max_index_frame:end,:);
sync_frame_gdata = frame_gdata(max_index_frame:end,:);
% for wheels, max value also occurs in y-direction because I had oriented
% phones to be upright prior to testing
[~, max_index_left] = max(left_data(:,3)); 
sync_left_data = left_data(max_index_left:end,:);
sync_left_gdata = left_gdata(max_index_left:end,:);
[~, max_index_right] = max(right_data(:,3));
sync_right_data = right_data(max_index_right:end,:);
sync_right_gdata = right_gdata(max_index_right:end,:);

% manually adjusting left dataset to match
left_temp = sync_left_data(500:1000,:);
[~, max_index_left_temp] = max(left_temp(:,3));
sync_left_data = sync_left_data(500+max_index_left_temp-1:end,:);
sync_left_gdata = sync_left_gdata(500+max_index_left_temp-1:end,:);

% shortening data sets to only capture first 20 seconds
frame_20s_val = 20*1000 + sync_frame_data(1,1);
frame_20s_index = find(sync_frame_data(:,1) >= frame_20s_val,1);
right_20s_val = 20*1000 + sync_right_data(1,1);
right_20s_index = find(sync_right_data(:,1) >= right_20s_val,1);
left_20s_val = 20*1000 + sync_left_data(1,1);
left_20s_index = find(sync_left_data(:,1) >= left_20s_val,1);

sync_frame_data = sync_frame_data(1:frame_20s_index,:);
sync_frame_gdata = sync_frame_gdata(1:frame_20s_index,:);
sync_right_data = sync_right_data(1:right_20s_index,:);
sync_right_gdata = sync_right_gdata(1:right_20s_index,:);
sync_left_data = sync_left_data(1:left_20s_index,:);
sync_left_gdata = sync_left_gdata(1:left_20s_index,:);

% adjusting the right wheel gyroscope dataset to be positive in value
sync_right_gdata = sync_right_gdata .* -1;

% graphing the SYNCED datasets
figure(1)
hold on
frame_time = (sync_frame_data(:,1) - sync_frame_data(1,1)) / 1000;
frame_acc_x = sync_frame_data(:,2);
frame_acc_y = sync_frame_data(:,3);
frame_acc_z = sync_frame_data(:,4);
plot(frame_time, frame_acc_y);
plot(frame_time, frame_acc_x);
plot(frame_time, frame_acc_z);
legend("y","x","z");
title("SYNC frame");
ylim([-5 15]);
hold off

figure(2)
hold on
right_time = (sync_right_data(:,1) - sync_right_data(1,1)) / 1000;
right_acc_x = sync_right_data(:,2);
right_acc_y = sync_right_data(:,3);
right_acc_z = sync_right_data(:,4);
plot(right_time, right_acc_y);
plot(right_time, right_acc_x);
plot(right_time, right_acc_z);
legend("y","x","z");
title("SYNC right");
ylim([-15 15]);
hold off

figure(3)
hold on
left_time = (sync_left_data(:,1) - sync_left_data(1,1)) / 1000;
left_acc_x = sync_left_data(:,2);
left_acc_y = sync_left_data(:,3);
left_acc_z = sync_left_data(:,4);
plot(left_time, left_acc_y);
plot(left_time, left_acc_x);
plot(left_time, left_acc_z);
legend("y","x","z");
title("SYNC left");
ylim([-15 15]);
hold off

figure(4)
hold on
frame_gx = sync_frame_gdata(:,2);
frame_gy = sync_frame_gdata(:,3);
frame_gz = sync_frame_gdata(:,4);
plot(frame_time, frame_gy);
plot(frame_time, frame_gx);
plot(frame_time, frame_gz);
legend("y","x","z");
title("gyro SYNC frame");
hold off

figure(5)
hold on
right_gx = sync_right_gdata(:,2);
right_gy = sync_right_gdata(:,3);
right_gz = sync_right_gdata(:,4);
plot(right_time, right_gy);
plot(right_time, right_gx);
plot(right_time, right_gz);
legend("y","x","z");
title("gyro SYNC right");
hold off

figure(6)
hold on
left_gx = sync_left_gdata(:,2);
left_gy = sync_left_gdata(:,3);
left_gz = sync_left_gdata(:,4);
plot(left_time, left_gy);
plot(left_time, left_gx);
plot(left_time, left_gz);
legend("y","x","z");
title("gyro SYNC left");
hold off

% finding total seconds that synced dataset captures
total_frame_time = frame_time(end) - frame_time(1);
total_left_time = left_time(end) - left_time(1);
total_right_time = right_time(end) - right_time(1);

% creating final dataset
synced_frame_acc = [frame_time, sync_frame_data(:,2:4)];
synced_frame_angvel = [frame_time, sync_frame_gdata(:,2:4)];
synced_left_acc = [left_time, sync_left_data(:,2:4)];
synced_left_angvel = [left_time, sync_left_gdata(:,2:4)];
synced_right_acc = [right_time, sync_right_data(:,2:4)];
synced_right_angvel = [right_time, sync_right_gdata(:,2:4)];

% writing final dataset to new files
writematrix(synced_frame_acc, 'PROCESSED DATA/straight 46ft/frame acc.csv');
writematrix(synced_frame_angvel, 'PROCESSED DATA/straight 46ft/frame angvel.csv');
writematrix(synced_right_acc, 'PROCESSED DATA/straight 46ft/right acc.csv');
writematrix(synced_right_angvel, 'PROCESSED DATA/straight 46ft/right angvel.csv');
writematrix(synced_left_acc, 'PROCESSED DATA/straight 46ft/left acc.csv');
writematrix(synced_left_angvel, 'PROCESSED DATA/straight 46ft/left angvel.csv');