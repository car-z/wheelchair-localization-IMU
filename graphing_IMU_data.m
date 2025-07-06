clearvars
close all
clc

frame_acc = readmatrix('PROCESSED DATA/straight 46ft/frame acc.csv');
frame_angvel = readmatrix('PROCESSED DATA/straight 46ft/frame angvel.csv');
left_acc = readmatrix('PROCESSED DATA/straight 46ft/left acc.csv');
left_angvel = readmatrix('PROCESSED DATA/straight 46ft/left angvel.csv');
right_acc = readmatrix('PROCESSED DATA/straight 46ft/right acc.csv');
right_angvel = readmatrix('PROCESSED DATA/straight 46ft/right angvel.csv');

figure('Position', [200, 200, 1200, 700])
tiledlayout(2,3);

nexttile;
hold on
%frame_acceleration = sqrt(frame_acc(:,2).^2 + frame_acc(:,3).^2 + frame_acc(:,4).^2);
plot(frame_acc(:,1), frame_acc(:,2));
plot(frame_acc(:,1), frame_acc(:,3));
plot(frame_acc(:,1), frame_acc(:,4));
legend('x','y','z')
xlabel("Time (seconds)");
ylabel("Acceleration (m/s^2)");
ylim([-5 15]);
title("Frame acceleration");
hold off

nexttile;
hold on
%left_acceleration = sqrt(left_acc(:,2).^2 + left_acc(:,3).^2 + left_acc(:,4).^2);
plot(left_acc(:,1), left_acc(:,2));
plot(left_acc(:,1), left_acc(:,3));
plot(left_acc(:,1), left_acc(:,4));
legend('x','y','z')
xlabel("Time (seconds)");
ylabel("Acceleration (m/s^2)");
ylim([-15 15]);
title("Left acceleration");
hold off

nexttile;
hold on
%right_acceleration = sqrt(right_acc(:,2).^2 + right_acc(:,3).^2 + right_acc(:,4).^2);
plot(right_acc(:,1), right_acc(:,2));
plot(right_acc(:,1), right_acc(:,3));
plot(right_acc(:,1), right_acc(:,4));
legend('x','y','z')
xlabel("Time (seconds)");
ylabel("Acceleration (m/s^2)");
ylim([-15 15]);
title("Right acceleration");
hold off

nexttile;
hold on
plot(frame_angvel(:,1), frame_angvel(:,2));
plot(frame_angvel(:,1), frame_angvel(:,3));
plot(frame_angvel(:,1), frame_angvel(:,4));
legend('x','y','z');
xlabel("Time (seconds)");
ylabel("Angular Velocity (rad/s)");
title("Frame Angular Velocity");
hold off

nexttile;
hold on
plot(left_angvel(:,1), left_angvel(:,2));
plot(left_angvel(:,1), left_angvel(:,3));
plot(left_angvel(:,1), left_angvel(:,4));
legend('x','y','z');
xlabel("Time (seconds)");
ylabel("Angular Velocity (rad/s)");
title("Left Angular Velocity");
hold off

nexttile;
hold on
plot(right_angvel(:,1), right_angvel(:,2));
plot(right_angvel(:,1), right_angvel(:,3));
plot(right_angvel(:,1), right_angvel(:,4));
legend('x','y','z');
xlabel("Time (seconds)");
ylabel("Angular Velocity (rad/s)");
title("Right Angular Velocity");
hold off
