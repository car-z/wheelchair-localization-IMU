data = readmatrix('leftwheel-14ft-gyro.txt');

time = (data(:,1) - data(1,1)) / 1000;
total_time = time(end) - time(1)

% rad/s
angvel_z = data(:,4);

figure(1);

plot(time, angvel_z);
xlabel("Time (seconds)",'FontSize',14);
ylabel("Angular Velocity (rad/s)",'FontSize',14);
title("Angular Velocity vs Time of Wheelchair (left wheel)",'FontSize',14);

radius = 12 * 0.0254; % 12 inch radius = 0.3048 meters
linvel_z = angvel_z * radius;

dist_z = cumtrapz(time, linvel_z);

ground_truth_displacement = linspace(0, 4.2672, length(dist_z))'; %4.2672m = 14ft

figure(2);
plot(time, dist_z);
hold on
plot(time, ground_truth_displacement);
xlabel("Time (seconds)",'FontSize',14);
ylabel("Displacement (m)",'FontSize',14);
legend("integrated displacement", "ground truth");
% % title("Displacment vs Time of Non-Moving Device",'FontSize',18);
title("Displacement vs Time of Wheelchair (wheel)",'FontSize',14);

