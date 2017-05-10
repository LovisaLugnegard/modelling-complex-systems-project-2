%assignment 3_3

chromosomes = zeros(50,54);
fitness = zeros(1,50); %stores each chrom's fitness
environment = zeros(20,40);
newChromosomes = zeros(50,54);
T = 2; %number of time steps
S = 10; %number of runs for each generation
p = 0.05; %probability for genetic mutation
trajectory = zeros(100,800);
avgFitness = zeros(1,T);
%create 50 random chromosomes
for i=1:50
    for j = 1:54
        chromosomes(i,j) = ceil(rand*4);
    end
end

for i=1:S
    for j = 1:50
        [performance, traj] = oneChromePerf(environment, chromosomes(j,:));
        %spara medelvärdet av fitness i en vektor
        fitness(j) = fitness(j) + performance;
    end
end
fitness = fitness/S; %divide by 10 to get mean val of fitness
avgFitness(1) = sum(fitness)/50;

for t=1:T
    
    P = fitness/sum(fitness); %probabilities for each chrom
    
    Q = cumsum(P);
    
    %create 25 pairs of chromosomes
    for i=1:25
        %select chromosome
        chromA = find(rand<Q,1);
        chromB = find(rand<Q,1);
        crossOverPos = ceil(rand*54);
        
        %swap parts of chromA and chromB
        newChromosomes(i,1:crossOverPos) = chromosomes(chromA, 1:crossOverPos);
        newChromosomes(i,crossOverPos+1:54) = chromosomes(chromB, crossOverPos+1:54);
        newChromosomes(i+25,1:crossOverPos) = chromosomes(chromB, 1:crossOverPos);
        newChromosomes(i+25,crossOverPos+1:54) = chromosomes(chromA, crossOverPos+1:54);
        if(rand<p)
            mutation = ceil(rand*4);
            r = ceil(rand*54);
            newChromosomes(i,r) = mutation;
        end
        
        if(rand<p)
            mutation = ceil(rand*4);
            r = ceil(rand*54);
            newChromosomes(i+25,r) = mutation;
        end
        
    end
    %now newChromosomes is updated, 50 new chromosomes are created
    fitness = zeros(1,50);
    for i=1:10
        for j = 1:50
            [performance, traj] = oneChromePerf(environment, chromosomes(j,:));
            %spara medelvärdet av fitness i en vektor
            fitness(j) = fitness(j) + performance;
            
            if(t == T && i == S)
                traj = traj';
                trajectory(2*j-1,:) = traj(1,:);
                trajectory(2*j,:) = traj(2,:);
            end
        end
    end
    fitness = fitness/S; %divide by 10 to get mean val of fitness
    avgFitness(t+1) = sum(fitness)/50;
    chromosomes = newChromosomes;
end

[maxFit, ind] = max(fitness);

disp(chromosomes(ind,:))

world = zeros(20,40);

for i = 1:800
    world(trajectory(2*ind-1,i), trajectory(2*ind,i)) =...
        world(trajectory(2*ind-1,i), trajectory(2*ind,i)) + 1;
end


%calculate the gengetic diversity

D = (1/L)*symsum(sum()/(N(N-1)),k,1,L);
 
%plot figures
figure
plot(avgFitness)


figure
imagesc(world)
figure %display trajectory in a plot



%imagesc(trajectory(2*ind-1:2*ind, :))
scatter(trajectory(2*ind-1,800), trajectory(2*ind,800)); %starting position
hold on
scatter(trajectory(2*ind-1,1),trajectory(2*ind,1), 'filled'); %end pos (filled circle)
plot(trajectory(2*ind-1,:), trajectory(2*ind,:))
fprintf('Performace: %d \n', maxFit);


