%simulation 3.1

clear;
numC = 54; %number of chromosomes
R = 20; %size of grid (num of rows in matrix)
C = 40; %size of grid (num of cols in matrix)
chromosome = 4.*ones(1,numC); % 1: go straight; 2: turn left; 3: turn right; 4:
%random turn left or right) in the 54 different cases
environment = zeros(R,C); %each point can be painted, empty or inaccessible

[performance, trajectory] = oneChromePerf(environment, chromosome);
disp('Trajectory (as a stack, ie first position at the bottom)')
disp(trajectory)

figure %display trajectory in a plot
scatter(trajectory(800,1), trajectory(800,2)); %starting position
hold on
scatter(trajectory(1,1),trajectory(1,2), 'filled'); %end pos (filled circle)
plot(trajectory(:,1), trajectory(:,2))
fprintf('Performace: %d \n', performance);

