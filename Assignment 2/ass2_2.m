%2_2, bifurcation diagram
clear;
qVals = 0:0.1:0.9;
range = 0:1;
N = 50; %number of individuals
T = 1000; %# of time steps
tempDir = zeros(1,N);
p = 0.1;
R = 2;
L = 20; %size of world
S = 10; %number if simulations
noise = 0.1;
delta = 0.5;
xInd = rand(1,N)*L ;%all individuals x coords
%ok

yInd = rand(1,N)*L; %all individuals y coords
%ok
dir = pi.*2.*rand(1,N); %set initial direction for all individuals
%disp(dir) ok!
PsiMat=zeros(S*100,length(qVals));

h = waitbar(0, 'Progress');
lenqVals = length(qVals);
psi = zeros(1,100); %vector to store psi values

bifurMat = zeros(101,length(qVals));
for j=1:lenqVals
    q = qVals(j);
    for s = 1:S
        for t = 1:T
            for i = 1:N %calc all tempDir by calling function
                tempDir(i) = calNewDir(i, xInd, yInd, dir, N, L, R,p,q);
            end
            dir = tempDir + noise.*rand(1,N) - noise/2; %add noise and update direction vector
            dxb=delta.*cos(dir); %where are all individuals going x direction
            dyb=delta.*sin(dir); %where are all individuals going y direction
            
            %implement periodic BC
            xInd = mod(xInd + dxb + L, L);
            yInd = mod(yInd + dyb + L, L);
            
            if(t>(T-100))
                psi(T+1-t) = (1/N)*sqrt((sum(cos(dir)))^2 + (sum(sin(dir)))^2);
            end
            
        end
        PsiMat((1+100*(s-1):s*100), j)=psi'; %store all psi values in a matrix, used in bifur dia
                
    end
    waitbar(j/lenqVals);
end


figure
edges = 0 : 0.01 : 1.01;
mapM = zeros(length(edges)-1, length(qVals));
for i = 1 : length(qVals)
    temp = histogram(PsiMat(:, i), edges);
    mapM(:, i) = temp.Values;
end
imagesc(qVals, edges, mapM)
