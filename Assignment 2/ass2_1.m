%Simulation 2.1

clear;
close all;
L = 20; %size of the world
delta = 0.5; %distance traveled /time step
R = 2; %radius
noise = 0.1; %noise parameter
N = 50; %#of birds
p = 1;
q = 0;


birds = (1:N);
dist = (1:N);
interactionBirds = (1:N);

xbirds = rand(1,N).*L;%all birds x coords
disp(xbirds)
ybirds = rand(1,N).*L;%all birds y coords
disp(ybirds)
figure
axis([0 L 0 L])
axis('square')
hold on


dir = pi.*2.*rand(1,N); %set initial direction for all birds
tempDir = (1:N);


%outer loop

for t=1:20000
    
    ran = rand;
    dxb=delta.*cos(dir); %where are all birds going x direction
    dyb=delta.*sin(dir); %where are all birds going y direction
    
    xbirds = mod(xbirds + dxb + L, L);
    ybirds = mod(ybirds + dyb + L, L);
    for i=1:N
        k = 0; %number of bird within the interaction zone
        for j=1:N
            
            %implement periodic boundary condition
            minX = min(abs(xbirds(i) - xbirds(j)), abs(L + xbirds(i) - xbirds(j)));
            minY = min(abs(ybirds(i) - ybirds(j)), abs(L + ybirds(i) - ybirds(j)));
            
            %calculate the distance to bird j
            dist(j) = sqrt(minX^2 + minY^2);
            % dist > 0 to avoid taking bird i
            if(dist(j)<R && dist(j)>0)
                k = k + 1;
                interactionBirds(k) = j; %which birds are within the interaction zone
            end
        end
        
        if(k == 0 || ran>p + q) %do not change dir if there are no other birds in the interaction zone, or
            %the random variable says so
            tempDir(i) = dir(i);
        elseif(ran<=p) %changes directional angle to face directly towards the neighbour j
            interactBird = getInteractionBird(k, interactionBirds);

            if(abs(xbirds(i) - xbirds(interactBird)) < abs(L + xbirds(i) - xbirds(interactBird)))
                minDisX = xbirds(i) - xbirds(interactBird);
            else
                minDisX = L + xbirds(i) - xbirds(interactBird);
            end
            
            if(abs(ybirds(i) - ybirds(interactBird)) < abs(L + ybirds(i) - ybirds(interactBird)))
                minDisY = ybirds(i) - ybirds(interactBird);
            else
                minDisY = L + ybirds(i) - ybirds(interactBird);
            end         
            tempDir(i) = atan(minDisY/minDisX);
            
        elseif(ran<=p+q) %with probability q bird i takes the directional angle of neighbour j
            interactBird = getInteractionBird(k, interactionBirds);
            tempDir(i) = dir(interactBird);
        end        
    end
    
    dir = tempDir + noise.*rand(1,N) - noise/2; %add noise and update direction vector
  
    %plot
    cla
    plot(xbirds,ybirds,'b>')
    drawnow
end

function res = getInteractionBird(numOfBirds, interactionBirds)
num = ceil(rand*numOfBirds);
res = interactionBirds(num);
end
