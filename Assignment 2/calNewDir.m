
function res = calNewDir(i, xInd, yInd, dir, N, L, R,p,q)
interactionInd = (1:N-1);
%tempDir = zeros(1, N);

ran = rand; %will decide which case to go into later
k = 0; %number of individuals within the interaction zone
for j=1:N
    if(j~=i) %avoid taking individual i
        %implement periodic boundary condition
        minX = min(abs(xInd(i) - xInd(j)), abs(L + xInd(i) - xInd(j)));
        minY = min(abs(yInd(i) - yInd(j)), abs(L + yInd(i) - yInd(j)));
        
        %calculate the distance to individual j
        dist = sqrt(minX^2 + minY^2);
        if(dist<R)
            k = k + 1;
            interactionInd(k) = j; %which individuals are within the interaction zone
        end
    end
end

if(k == 0 || ran> p + q) %do not change dir if there are no other individuals in the interaction zone, or
    %the random variable says so
    tempDir = dir(i);
elseif(ran<=p) %changes directional angle to face directly towards the neighbour j
    %draw random individual in the interaction zone
  % disp("ran mindre an p")
    interactInd = getInteractionInd(k, interactionInd);
 %   disp(interactInd)
    if(abs(xInd(i) - xInd(interactInd)) < abs(L + xInd(i) - xInd(interactInd)))
        minDisX = xInd(i) - xInd(interactInd);
    else
        minDisX = L + xInd(i) - xInd(interactInd);
    end
    
    if(abs(yInd(i) - yInd(interactInd)) < abs(L + yInd(i) - yInd(interactInd)))
        minDisY = yInd(i) - yInd(interactInd);
    else
        minDisY = L + yInd(i) - yInd(interactInd);
    end
    
    %calculate new angle
    if(minDisX > 0 && minDisY > 0)
        tempDir = pi + atan(abs(minDisY/minDisX));
    elseif(minDisX > 0 && minDisY < 0)
        tempDir = pi - atan(abs(minDisY/minDisX));
    elseif(minDisX < 0 && minDisY < 0)
        tempDir = 2 * pi + atan(abs(minDisY/minDisX));
    elseif(minDisX < 0 && minDisY > 0)
        tempDir = atan(abs(minDisY/minDisX));
    end
    
elseif(ran<=p+q) %with probability q individual i takes the directional angle of neighbour j
   % disp("ran mellan p och q")
    interactInd = getInteractionInd(k, interactionInd);
    tempDir = dir(interactInd);
end

res = tempDir;
end

%function to find random individual within the interaction zone
function res = getInteractionInd(numOfInd, interactionInd)
num = ceil(rand*numOfInd);
res = interactionInd(num);
end