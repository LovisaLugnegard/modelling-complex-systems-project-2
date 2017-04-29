% Assignment 1.1, project 2, Undirected social network

N = 5000; %number of individuals
d = 0.0016; %link density
numLinks = zeros(1,N); %vector needed for histogram

%create random network
networkMatrix = createRanSocNet(N,d);
% networkMatrix = zeros(N);
% for i = 1:N
%     for j = i+1:N
%         r = rand;
%         if(r<=p)
%             networkMatrix(i,j) = 1;
%             networkMatrix(j,i) = 1;
%         end
%     end
% end

for i = 1:N
    numLinks(i) = sum(networkMatrix(i,:));
end

%cal average degree of network

avgDeg = sum(sum(networkMatrix))/N;
disp(avgDeg)

%plot histogram of degree distribution
histogram(numLinks)
xlabel('Number of links')
