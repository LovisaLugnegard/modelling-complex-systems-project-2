%assignment 1.2, infected individuals

p = 0.01; %model constant
r = 0.03; %probability for an individual to recover/day
T = 1000; %number of days (time steps)
d = 0.0016;
N = 5000;
i = 1;

individuals = zeros(1,N); %vector with all individuals (1=infected)
tempInd = zeros(1,N); %temp vector of all individuals (1=infected)
numOfInfectedInd = zeros(1,T);

%create random social network
networkMatrix = createRanSocNet(N,d);

%infect 100 random individuals individuals
while i<=100
    infected = ceil(rand*N);
    if(individuals(infected) == 0)
        individuals(infected) = 1;
        i = i+1;
    end
end

h = waitbar(0, 'Progress');

for t = 1:T
    for j = 1:N %for each individual
        n = 0; %number of connected infected individuals
        if(individuals(j) == 0) %individual not infected
            for k = 1:N %search for linked infected indivíduals
                if(networkMatrix(j,k) == 1 && individuals(k) == 1)
                    n = n + 1; %if linked and infected, increment n
                end
            end           
            ran = rand; %random number to decide in individual j becomes infected
            if(ran <= 1-exp(-p*n))
                tempInd(j) = 1; %infected
            else
                tempInd(j) = 0; %not infected
            end           
        else %indvidual j is already infected
            ran = rand;
            if(ran<=0.03) %recover
                tempInd(j) = 0;
            else %did not recover
                tempInd(j) = 1;
            end
        end
        
    end
    individuals = tempInd; %update the indivíduals vector
    numOfInfectedInd(t) = sum(individuals); %all infected individuals at given time
    waitbar(t/T);
end

%plot
plot(numOfInfectedInd)





