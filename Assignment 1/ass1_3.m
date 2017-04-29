%assignment 1.3, project 2

pVals = 0.001:0.001:0.01;

r = 0.03; %probability for an individual to recover/day
T = 1000; %number of days (time steps)
d = 0.0016;
N = 5000;

infIndStopTime = zeros(1,length(pVals));

    h = waitbar(0, 'Progress');
for m = 1:length(pVals)
    i = 1;
    individuals = zeros(1,N); %vector with all individuals (1=infected)
    tempInd = zeros(1,N); %temp vector of all individuals (1=infected)
    numOfInfectedInd = zeros(1,T);
    
    p = pVals(m);
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
    
    for t = 1:T
        %för varje individ,
        %om individuals(individ)==0 kolla hur många länkade som är infekterade
        %ränka ut om ind blir infekterad
        %om individuals(individ)==1 recover med sannolikhet 0.03
        for j = 1:N
            n = 0; %number of connected infected individuals
            if(individuals(j) == 0)
                for k = 1:N
                    if(networkMatrix(j,k) == 1 && individuals(k) == 1)
                        n = n + 1;
                    end
                end
                
                ran = rand;
                if(ran <= 1-exp(-p*n))
                    tempInd(j) = 1;
                else
                    tempInd(j) = 0;
                end
            else
                ran = rand;
                if(ran<=0.03) %recover
                    tempInd(j) = 0;
                else %did not recover
                    tempInd(j) = 1;
                end
            end
            
        end
        individuals = tempInd;
        numOfInfectedInd(t) = sum(individuals);
        
    end
    infIndStopTime(m) = numOfInfectedInd(T);
    waitbar(m/length(pVals));
    plot(numOfInfectedInd);
    xlabel('Time [days]')
    ylabel('Number of infected individuals')
    legend('p=0.001', 'p=0.002', 'p=0.003', 'p=0.004', 'p=0.005', ...
        'p=0.006', 'p=0.007', 'p=0.008', 'p=0.009', 'p=0.01')
    hold on
end

figure
scatter(r./pVals, infIndStopTime, 'filled')
xlabel('r/q')
ylabel('Number of infected individuals on day 1000')

%disp(r./pVals)