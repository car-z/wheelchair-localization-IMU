% static_data = readmatrix('frame-14ft-acc.txt');
data = readmatrix('frame-14ft-acc.txt');

time = (data(:,1) - data(1,1)) / 1000;
total_time = time(end) - time(1)

acc_x = data(:,2);
acc_y = data(:,3);
acc_z = data(:,4);

acceleration = sqrt(acc_x.^2 + acc_y.^2 + acc_z.^2);

figure(1);

plot(time, acceleration);
xlabel("Time (seconds)",'FontSize',14);
ylabel("Acceleration (m/s^2)",'FontSize',14);
% title("Acceleration vs Time of Non-Moving Device",'FontSize',18);
title("Acceleration vs Time of Wheelchair (frame)",'FontSize',14);

vel_x = cumtrapz(time, acc_x);
vel_y = cumtrapz(time, acc_y);
vel_z = cumtrapz(time, acc_z);
dist_x = cumtrapz(time, vel_x);
dist_y = cumtrapz(time, vel_y);
dist_z = cumtrapz(time, vel_z);

displacement = sqrt(dist_x.^2 + dist_y.^2  + dist_z.^2);
%ground_truth_displacement = linspace(0, 0, length(displacement)-100)';
ground_truth_displacement = linspace(0, 4.2672, length(displacement))'; %4.2672m = 14ft

figure(2);
plot(time, displacement);
hold on
plot(time, ground_truth_displacement);
xlabel("Time (seconds)",'FontSize',14);
ylabel("Displacement (m)",'FontSize',14);
legend("double integrated displacement", "ground truth");
% title("Displacment vs Time of Non-Moving Device",'FontSize',18);
title("Displacement vs Time of Wheelchair (frame)",'FontSize',14);

