close all 
clear

frame_data = readmatrix('frame/46ft-acc.txt');
right_data = readmatrix('right wheel/46ft-acc.txt');
% frame_gdata = readmatrix('frame/46ft-gyro.txt');
% right_gdata = readmatrix('right wheel/46ft-gyro.txt');

% using 10s of standstill data to get a measure of gravity

% extracting first 10s of frame
frame_10s_val = 10*1000 + frame_data(1,1);
frame_10s_index = find(frame_data(:,1) >= frame_10s_val,1);
frame_data10 = frame_data(1:frame_10s_index,:);
% frame_gdata10 = frame_gdata(1:frame_10s_index,:);

% extracting last 10s of right wheel
right_10s_start_val = 58*1000+right_data(1,1);
right_10s_start_index = find(right_data(:,1) >= right_10s_start_val,1);
right_10s_end_val = 68*1000+right_data(1,1);
right_10s_end_index = find(right_data(:,1) >= right_10s_end_val,1);
right_data10 = right_data(right_10s_start_index:right_10s_end_index,:);
% right_gdata10 = right_gdata(right_10s_start_index:right_10s_end_index,:);

% figure(1)
% hold on
% frame_time = (frame_data10(:,1) - frame_data10(1,1)) / 1000;
% frame_acc_x = frame_data10(:,2);
% frame_acc_y = frame_data10(:,3);
% frame_acc_z = frame_data10(:,4);
% plot(frame_time, frame_acc_y);
% plot(frame_time, frame_acc_x);
% plot(frame_time, frame_acc_z);
% legend("y","x","z");
% title("frame");
% hold off
% 
% figure(2)
% hold on
% right_time = (right_data10(:,1) - right_data(1,1)) / 1000;
% right_acc_x = right_data10(:,2);
% right_acc_y = right_data10(:,3);
% right_acc_z = right_data10(:,4);
% plot(right_time, right_acc_y);
% plot(right_time, right_acc_x);
% plot(right_time, right_acc_z);
% legend("y","x","z");
% title("right");
% hold off

grav = (mean(frame_data10(:,2:4)) + mean(right_data10(:,2:4)))/2;
grav_unit = grav / norm(grav) % unit vector of empirical gravity



