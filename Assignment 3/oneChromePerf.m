%function oneChromePerf
%outputs the performance of one chromosome
function [perf, traj] = oneChromePerf(environment, chromosome)

%find out how much paint needed
sz = size(environment); %get size of the environment
numOfFurn = sum(sum(environment == 1)); %get all inaccessible grid points
totalPaintCan = sz(1)*sz(2) - numOfFurn; %get how much there is in the paintcan, ie, how many elements in the matrix

painterSet = false; %the painter's starting pos is not set

while(painterSet == false) %set painter's start pos, check for furniture
    painter(1) = ceil(rand*sz(1)); %painter's start row
    painter(2) = ceil(rand*sz(2)); %painter's start col
    if(environment(painter(1), painter(2)) == 0)
        painterSet = true;
    end
end

trajectory = zeros(totalPaintCan, 2); %stores the traj as a "stack"
numOfVisGrids = 0; %the painter has not visited any grids
currentDir = round(rand*4); %starting direction for the painter
paintCan = totalPaintCan;

%find all possible combinations of neighbours 
A = [0 1 2]; 
caseVect = zeros(1,3);
combs = A(combinator(3,3,'p','r'));

while(paintCan > 0) %paint, continue as long as there is paint left
    if(environment(painter(1), painter(2)) == 0) %if the grid is not painted
        numOfVisGrids = numOfVisGrids + 1;
    end
    %check neighbouring grids to find which chromosome
    switch currentDir
        case 1%right
            for i = 1:3
                try
                    caseVect(i) = environment(painter(1) - 2+i, painter(2) + mod(i+1,2));
                catch
                    caseVect(i) = 1; %there is a wall
                end
            end
        case 2 %down
            for i = 1:3
                try
                    caseVect(i) = environment(painter(1) + mod(i+1,2), painter(2) +2-i);
                catch
                    caseVect(i) = 1; %there is a wall
                end
            end
        case 3 %left
            for i = 1:3
                try
                    caseVect(i) = environment(painter(1) + 2-i, painter(2)- mod(i+1,2));
                catch
                    caseVect(i) = 1; %there is a wall
                end
            end
        case 4 %currentDir == 4 %up
            for i = 1:3
                try
                    caseVect(i) = environment(painter(1) - mod(i+1,2), painter(2) - 2+i);
                catch
                    caseVect(i) = 1; %there is a wall
                end
            end
    end
    
    %translate a caseVect to a number (1 to 54)
    chrom = find(ismember(combs,caseVect,'rows'));
    if(environment(painter(1),painter(2)) == 0) %not painted
        chrom = chrom + 27;
    end
    
    %set the painter's new direction according to chromosome
    response = chromosome(chrom);
    switch response
        case 1 %continue forward
            newDir = forward(painter(1), painter(2), currentDir);
        case 2 %turn left
            newDir = turnLeft(painter(1), painter(2), currentDir);
        case 3 %turn right
            newDir = turnRight(painter(1), painter(2), currentDir);
        case 4
            r = rand;
            if(r<0.5) %turn left
                newDir = turnLeft(painter(1), painter(2), currentDir);
            else
                newDir = turnRight(painter(1), painter(2), currentDir);
            end
    end
    
    if(newDir(1)>0 && newDir(1)<=sz(1) && newDir(2)>0 ...
            && newDir(2)<=sz(2) && environment(newDir(1),newDir(2))~=1)
        trajectory(paintCan, 1) = painter(1);
        trajectory(paintCan, 2) = painter(2);
        environment(painter(1), painter(2)) = 2; %paint current grid spot
        painter(1) = newDir(1);
        painter(2) = newDir(2);
        currentDir = newDir(3);
        paintCan = paintCan - 1; %used paint to paint currentgrid spot
    else
        while(paintCan > 0)
            trajectory(paintCan, 1) = painter(1);
            trajectory(paintCan, 2) = painter(2);
            paintCan = paintCan - 1;
        end
    end
    
end
performance = numOfVisGrids/totalPaintCan;
perf = performance;
traj = trajectory;
end

function res = turnRight(r,c,currentDir)
switch currentDir
    case 1 %current direction right
        r = r+1;
        currentDir = 2;
    case 2 %current direction down
        c = c-1;
        currentDir = 3;
    case 3 %current direction left
        r = r-1;
        currentDir = 4;
    case 4 %current direction up
        c = c+1;
        currentDir = 1;
end
res = [r c currentDir];
end

function res = turnLeft(r,c,currentDir)
switch currentDir
    case 1 %current direction right
        r = r-1;
        currentDir = 4;
    case 2 %current direction down
        c = c+1;
        currentDir = 1;
    case 3 %current direction left
        r = r+1;
        currentDir = 2;
    case 4 %current direction up
        c = c-1;
        currentDir = 3;
end
res = [r c currentDir];
end

function res = forward(r,c,currentDir)
switch currentDir
    case 1 %current direction right
        c = c+1;
    case 2 %current direction down
        r = r+1;
    case 3 %current direction left
        c = c-1;
    case 4 %current direction up
        r = r-1;
end
res = [r c currentDir];
end
