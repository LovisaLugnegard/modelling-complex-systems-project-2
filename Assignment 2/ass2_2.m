%2_2, bifurcation diagram

qVals = 0:0.1:0.9;
range = 0:1;
N = 50;
T = 500; %# of time steps
tempDir = zeros(1,N);
p = 0.1;
R = 2;
L = 20;
S = 100; %number if simulations
noise = 0.1;
delta = 0.5;
%psi = zeros(length(qVals),T);
%kör calNewDir för alla q
xInd = rand(1,N).*L ;%all individuals x coords
yInd = rand(1,N).*L; %all individuals y coords
dir = pi.*2.*rand(1,N); %set initial direction for all individuals

h = waitbar(0, 'Progress');
lenqVals = length(qVals);

psi = zeros(1,10);

bifurMat = zeros(101,length(qVals));
for j=1:lenqVals
    q = qVals(j);
    for s = 1:S
        for t = 1:T
            for i = 1:N
                tempDir(i) = calNewDir(i, xInd, yInd, dir, N, L, R,p,q);
            end
            dir = tempDir + noise.*rand(1,N) - noise/2; %add noise and update direction vector
            dxb=delta.*cos(dir); %where are all individuals going x direction
            dyb=delta.*sin(dir); %where are all individuals going y direction
            xInd = mod(xInd + dxb + L, L);
            yInd = mod(yInd + dyb + L, L);
            
            if(t>=(T-10))
%                 disp('dir')
%                 disp(length(dir))
%                 disp(N)
%                 disp(dir)
                psi(T-t+1) = (1/N)*sqrt((sum(cos(dir)))^2 + (sum(sin(dir)))^2);
                %  disp(psi)
            end
        end
        
        for k=1:10
            bifurMat(round(100*psi(k))+1,j) = bifurMat(round(100*psi(k))+1,j) +1;
        end
        %cal alignmentMeasure
        %  psi = (1/N)*sqrt(sum(cos(dir))^2 + sum(sin(dir))^2);
%         
%         disp(round(100.*psi))
%         disp(psi)
        
        % scatter(q,psi(j,t),'b');
        %hold on
    end
    waitbar(j/lenqVals);
end
%disp(psi)



% for i=1:length(qVals)
%     q = qVals(i);
%     for j=1:T
%         scatter(psi(
%     end
% end

imagesc(qVals,range,bifurMat)
% xlabel('q')
% ylabel('Alignment measure')
% title('Bifurcation diagram alignment measure vs q')
 colorbar