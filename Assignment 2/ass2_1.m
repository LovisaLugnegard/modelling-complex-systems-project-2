%Simulation 2.1

clear;
close all;
L = 20; %size of the world
delta = 0.5; %distance traveled /time step
R = 2; %radius
noise = 0.1; %noise parameter
N = 50; %#of individuals
p = 1;
q = 0;
T = 10000; %# of time steps

interactionInd = (1:N-1); %vector to store ind in interact zone

xInd = rand(1,N).*L ;%all individuals x coords
yInd = rand(1,N).*L; %all individuals y coords

%initialize figure where the individuals will be plotted
sAxis = axes;
hData = plot(sAxis,nan,nan,'o');
axis(sAxis,[0 20 0 20])

dir = pi.*2.*rand(1,N); %set initial direction for all individuals
tempDir = zeros(1,N); %vector to store temp directions in each time step

%outer loop, each time step
for t=1:T
    for i=1:N
        tempDir(i) = calNewDir(i, xInd, yInd, dir, N, L, R,p,q);

%         ran = rand; %will decide which case to go into later
%         k = 0; %number of individuals within the interaction zone
%         for j=1:N
%             if(j~=i) %avoid taking individual i
%                 %implement periodic boundary condition
%                 minX = min(abs(xInd(i) - xInd(j)), abs(L + xInd(i) - xInd(j)));
%                 minY = min(abs(yInd(i) - yInd(j)), abs(L + yInd(i) - yInd(j)));
%                 
%                 %calculate the distance to individual j
%                 dist = sqrt(minX^2 + minY^2);
%                 if(dist<R)
%                     k = k + 1;
%                     interactionInd(k) = j; %which individuals are within the interaction zone
%                 end
%             end
%         end
%         
%         if(k == 0 || ran> p + q) %do not change dir if there are no other individuals in the interaction zone, or
%             %the random variable says so
%             tempDir(i) = dir(i);
%         elseif(ran<=p) %changes directional angle to face directly towards the neighbour j
%             %draw random individual in the interaction zone
%             disp("ran mindre an p")
%             interactInd = getInteractionInd(k, interactionInd);
%             disp(interactInd)
%             if(abs(xInd(i) - xInd(interactInd)) < abs(L + xInd(i) - xInd(interactInd)))
%                 minDisX = xInd(i) - xInd(interactInd);
%             else
%                 minDisX = L + xInd(i) - xInd(interactInd);
%             end
%             
%             if(abs(yInd(i) - yInd(interactInd)) < abs(L + yInd(i) - yInd(interactInd)))
%                 minDisY = yInd(i) - yInd(interactInd);
%             else
%                 minDisY = L + yInd(i) - yInd(interactInd);
%             end
%             
%             %calculate new angle
%             if(minDisX > 0 && minDisY > 0)
%                 tempDir(i) = pi + atan(abs(minDisY/minDisX));
%             elseif(minDisX > 0 && minDisY < 0)
%                 tempDir(i) = pi - atan(abs(minDisY/minDisX));
%             elseif(minDisX < 0 && minDisY < 0)
%                 tempDir(i) = 2 * pi + atan(abs(minDisY/minDisX));
%             elseif(minDisX < 0 && minDisY > 0)
%                 tempDir(i) = atan(abs(minDisY/minDisX));
%             end
%                     
%         elseif(ran<=p+q) %with probability q individual i takes the directional angle of neighbour j
%             disp("ran mellan p och q")
%             interactInd = getInteractionInd(k, interactionInd);
%             tempDir(i) = dir(interactInd);
%         end
    end
    
    dir = tempDir + noise.*rand(1,N) - noise/2; %add noise and update direction vector
    dxb=delta.*cos(dir); %where are all individuals going x direction
    dyb=delta.*sin(dir); %where are all individuals going y direction
    xInd = mod(xInd + dxb + L, L);
    yInd = mod(yInd + dyb + L, L);
    
    %plot
    set(hData,'XData',xInd,'YData',yInd);
    drawnow
end
%function to find random individual within the interaction zone
function res = getInteractionInd(numOfInd, interactionInd)
num = ceil(rand*numOfInd);
res = interactionInd(num);
end

