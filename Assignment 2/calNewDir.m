
function res = calNewDir(i, xInd, yInd, dir, N, L, R,p,q)
interactionInd = zeros(1,N-1); %all individuals to interact with are storerd here

xvecnew = zeros(1,N);
yvecnew = zeros(1,N);

ran = rand; %will decide which case to go into later
k = 0; %number of individuals within the interaction zone
for j=1:N %go through all other individuals to see if in interact zone
    if(j~=i) %avoid taking individual i
        %implement periodic boundary condition
        %         minX = min(abs(xInd(i) - xInd(j)), abs(L + xInd(i) - xInd(j)));
        %         minY = min(abs(yInd(i) - yInd(j)), abs(L + yInd(i) - yInd(j)));
        
        
        %implement periodic BC
        if L-xInd(i)<R && xInd(j)<R-(L-xInd(i))%check if close to right side
            xvecnew(j)=L+xInd(j);
        elseif xInd(i)<R && L-xInd(j)<R-xInd(i)%checks if close to left side
            xvecnew(j)=xInd(j)-L;
        else
            xvecnew(j)=xInd(j);
        end
        
        if L-yInd(i)<R && yInd(j)<R-(L-yInd(i))%check if close to upper side
            yvecnew(j)=L+yInd(j);
        elseif yInd(i)<R && L-yInd(j)<R-yInd(i)%checks if close to lower side
            yvecnew(j)=yInd(j)-L;
        else
            yvecnew(j)=yInd(j);
        end
        
        
        
        %calculate the distance to individual j
        %   dist = sqrt(minX^2 + minY^2);
        
        dist = sqrt(((xInd(i)-xvecnew(j))^2)+((yInd(i)-yvecnew(j))^2));
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
    % % %     if(abs(xInd(i) - xInd(interactInd)) < abs(L + xInd(i) - xInd(interactInd)))
    % % %         minDisX = xInd(i) - xInd(interactInd);
    % % %     else
    % % %         minDisX = L + xInd(i) - xInd(interactInd);
    % % %     end
    % % %
    % % %     if(abs(yInd(i) - yInd(interactInd)) < abs(L + yInd(i) - yInd(interactInd)))
    % % %         minDisY = yInd(i) - yInd(interactInd);
    % % %     else
    % % %         minDisY = L + yInd(i) - yInd(interactInd);
    % % %     end
    % % %
    % % %     %calculate new angle
    % % %     if(minDisX > 0 && minDisY > 0)
    % % %         tempDir = pi + atan(abs(minDisY/minDisX));
    % % %     elseif(minDisX > 0 && minDisY < 0)
    % % %         tempDir = pi - atan(abs(minDisY/minDisX));
    % % %     elseif(minDisX < 0 && minDisY < 0)
    % % %         tempDir = 2 * pi + atan(abs(minDisY/minDisX));
    % % %     elseif(minDisX < 0 && minDisY > 0)
    % % %         tempDir = atan(abs(minDisY/minDisX));
    % % %     end
    
    %kollad ok
    angle=atan((yvecnew(interactInd)-yInd(i))/(xvecnew(interactInd)-xInd(i)));
    
    if xvecnew(interactInd)<xInd(i) && yvecnew(interactInd)>yInd(i)
        tempDir=pi-abs(angle);
        
    elseif xvecnew(interactInd)<xInd(i) && yvecnew(interactInd)<yInd(i)
        tempDir=pi+abs(angle);
        
    elseif xvecnew(interactInd)>xInd(i) && yvecnew(interactInd)<yInd(i)
        tempDir=2*pi-abs(angle);
        
    else
        tempDir=angle;
        
    end %kollad ok
elseif(ran<=p+q) %with probability q individual i takes the directional angle of neighbour j
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