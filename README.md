# modelling-complex-systems-project-2
Modelling Complex Systems
Project Sheet 2
The deadline for project sheet 2 is Tuesday, 9th May (week 19), 23:59,
which is strict.
You are encouraged to work together in groups (2-4 people), but each person
should submit his or her own nal set of answers to the questions, with ex-
plicitly mentioning your collaborators (The course is assessed based on your
own answer sheet). Please look though or try to work the questions out be-
fore the lab sessions. I will try best to help you there.
It is preferred that simulations should be implemented in MATLAB, but
it is acceptable to use other languages. I will try to help with programming
problems in all languages, but \guarantee" help only in MATLAB.
Please submit hand-ins on Studentportalen. All codes should be submit-
ted as appendix and not as part of the answer to the hand-ins. If you want
to submit a video (which you are encouraged to do for some questions) then
put it on Studentportalen, or online if it is too large.
1
1 Network Epidemics
1. (1 point) Create a random undirected social network with 5000 indi-
viduals and a link density of 0.0016. That is, every pair of individuals
has a 0.16% chance of being linked to each other. Plot a histogram of
the degree distribution. What kind of distribution is this? What is the
average degree of this network?
2. (2 points) Simulate the following process on the network: Start with
100 random infected individuals. Every day, an individual connected
to n infected individuals becomes infected with probability
Pinfected(n) = 1 􀀀 e(􀀀pn)
per day, where p is a constant. An infected individual recovers with
constant probability r = 0:03 per day. Recovered individuals can be-
come infected again. Plot the number of infected individuals over the
rst 1000 days of the epidemic, using p = 0:01.
3. (2 points) Run the simulation for p = 0:001; 0:002; : : : ; 0:01. Plot the
number of infected individuals against time for each of these values
on the same graph. In a separate gure, plot the number of infected
individuals on day 1000 against r=p.
4. (2 points) Now create a social network using preferential attachment.
Start with time step t = 1, individuals 1 and 2 linked, individuals 3
and 4 linked. Every time step t add one individual and add m = 4
links linking it with other m individuals. The probability of the newly
added individual linking to individual i is proportional to the degree of
individual i (denoted as ki), that is
Plink(i; t) =
ki
total number of links at time t 􀀀 1
Try 100 time steps to make sure your algorithm works, and then build a
network of 5000 individuals. Plot a histogram of the degree distribution
on a log-log scale. What kind of distribution is this? What is the
average degree of the network?
2
5. (2 points) If the network keeps growing, the degree distribution be-
comes stationary in the long time limit, which means that for all k, the
number of nodes with degree k can be written as
Nk(t ! 1)  2mtnk
where the degree distribution nk sums to one. By using a mean eld
equation for Nk and inserting the above equation, nd a recurrence
relation for nk as a function of nk􀀀1. Show that this satises
nk =
c
k(k + 1)(k + 2)
where c is some constant. Does this agree with the distribution you
got from the simulation?
6. (3 points) Repeat question 2 and 3 for this preferential attachment
network. Make sure the initially infected individuals are chosen ran-
domly. Describe how the equilibrium number of infected individuals
depends on the infection probability p. How is this dierent to the
random network?
3
2 Self-propelled Particle Model
In this model, we have N individuals moving in a two dimensional world
with size L  L (periodic boundary).
1. (5 points) Implement the following self-propelled particle model of

ocking in two dimensions with both attraction and alignment terms.
An individual has position (xi(t); yi(t)) and a directional vector deter-
mined by angle i(t) and xed absolute distance traveled per time step
. On each time step an individual picks at random one neighbour j
within radius R. Then,
 With probability p it changes its directional angle to face directly
towards the neighbour j;
 With probability q it takes the directional angle of this neighbour
j ;
 With probability 1 􀀀 p 􀀀 q it maintains its previous direction i.
A random variable  with range [􀀀=2; =2] is then added to the direc-
tional angle.
For the whole exercise, x L = 20;  = 0:5;R = 2 and  = 0:1. Here
set the number of individuals N = 50, and then provide output of your
simulation for 1) p = q = 0:3; 2) p = 0 and q = 0:6; 3) p = 0:6 and
q = 0. Then change N and brie
y discuss how the dynamics changes
for dierent N (for the three dierent combinations of p and q).
2. (2 points) Here x N = 50 and p = 0:1, investigate how the alignment
measure
 (t) =
1
N
[(
XN
i=1
cos i(t))2 + (
XN
i=1
sin i(t))2]
changes as a function of q. In particular show the bifurcation as you
increase q. (Hint: you do not have to show the time series of  (t).
Instead, you draw the bifurcation diagram, with   vs. q.)
3. (3 points) Develop a measure of aggregation for your model. The
aggregation measure should capture how close together group members
are. Try dierent values of N; p and q to see if your measure is consistent
with the intuition of aggregation.
4
3 Evolving Painter Robot
Imagine we have a painter robot that works on grids space and moves grid
by grid. We will use this robot to paint the 
oor of a rectangular room with
or without furnitures. To make it interesting, the painter starts at a random
grid in the room, and paints continuously. We will also imagine that there
is exactly enough paint to cover the 
oor. This means that it is wasteful to
visit the same grid more than once. To see if there is an optimal set of rules
for the painter robot to follow, you will create a genetic algorithm.
1. (4 points) To start with, you need to create a function (let us call
it OneChromPerf()) which outputs the performance of one \chromo-
some". Particularly, as inputs it receives two variables:
 An environment: A 2D matrix (grids) representing a rectangu-
lar room with or without furnitures. Empty grids (which are
paintable) are represented by 0s, while walls and furnitures which
are inaccessible to the robot are represented by 1s.
 A chromosome: A 1  54 array of integers between 1 and 4 that
shows how to respond (1: go straight; 2: turn left; 3: turn right; 4:
random turn left or right) in each of the 54 possible states of the
robot. For the current grid the robot is located, there are only 2
cases, either empty or painted. For its current neighbouring grids,
there are 27 cases (empty / painted / inaccessible in grid forward
/ left / right = 33 = 27).
This function OneChromPerf(environment, chromosome) then uses the
rules indicated by this chromosome to guide the robot, initially placed
in the room with a random accessible grid and direction, until the paint
can is empty (note that the robot does not move when it tries to walk
into a wall or furniture). The eciency (total fraction of visited grids)
is then given as an output, as well as the trajectory of the robot.
Provide the outputs of your function. Here set the environment as
an empty 20  40 grids room, and the chromosome as a trivial one,
consisting of all 4s, which will produce a kind of random walk.
2. (1 point) Think of a simple strategy for the robot to cover a lot of
grids in that empty room. Describe this strategy in a few words or
sketch it, but you do not have to try to code it.
5
3. (4 points) Still x the environment as an empty 20  40 grids room.
Create 50 random chromosomes to start with, and make a genetic algo-
rithm to evolve this population over 200 generations (Play each chro-
mosome several times and store the chromosome's average eciency
as the tness; Use single-point crossover with a reasonable mutation
rate). Display the most successful chromosome, and plot the trajec-
tory. Is that what you expected?
4. (2 points) Plot the average tness in the chromosome population vs.
generation. And then plot the genetic diversity in the chromosome
population vs. generation. Is there any obvious relationship between
average tness and genetic diversity? What is your intuition?
We use the average number of pairwise dierences D as a measure of
genetic diversity, that is,
D =
1
L
XL
k=1
[
1
N(N 􀀀 1)
X
ij;i6=j
I(cik 6= cjk)]
where cik is the value of the ith chromosome at locus k, the indicator
I(s) is one if the discriminant s is true and zero otherwise, L is the
length of each chromosome (54 in this case), and N is the population
of chromosomes (50 in this case).
5. (3 points) Add some furnitures to the empty room (about 100 grids
in total). Use one of your highly evolved chromosomes, and plot the
trajectory of the robot. How does the eciency compare to that in an
empty room (if the strategy fails, try to explain why)? Now try running
the genetic algorithm with your new furnished room from the start, and
get the most successful strategy. Brie
y describe how it compares to
the most successful one for the empty room?
6
