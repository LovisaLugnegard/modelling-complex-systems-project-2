%assignment 1.4

 N = 4; %number of individuals
% i = 1;
 T = 5000; %number of time steps
% individuals = zeros(1,14); %storing number of links (degree) for each ind
% 
% networkMatrix = zeros(T+4);
% %create initial network
% while i<4
%     networkMatrix(i,i+1) = 1;
%     networkMatrix(i+1,i) = 1;
%     individuals(i) = 1;
%     individuals(i+1) = 1;
%     i = i+2;
% end
% 
% Plink = zeros(1,T);
% 
% waitbar(0, 'Progress');
% for t = 1:T
%     
%     N = N + 1; %add 1 individual
%     j = 1;
%     l = 0;
%     
%     Plink(1) = individuals(1)/(sum(individuals)/2-1); %calculatelink prob for
%     for n = 2:N-1
%         %calc link prob for all ind
%         Plink(n) = Plink(n-1) + individuals(n)/(sum(individuals)/2-1);
%     end
%     
%     %add 4 links
%     while l < 4
%         n = 1;
%         r = rand*Plink(N-1); %random number to decide connection
%         while r>Plink(n)
%             n = n+1;
%         end
% 
%         if(networkMatrix(N,n) == 0)
%             networkMatrix(N,n) = 1;
%             networkMatrix(n,N) = 1;
%             l = l+1;
%         end
%     end
%     
%     for m=1:N
%         individuals(m) = sum(networkMatrix(m,:));
%     end
%     
%     waitbar(t/T);
% end
networkMatrix = createPrefAttNet(4,T);
numLinks = zeros(1,N+T);

for i = 1:N+T
    numLinks(i) = sum(networkMatrix(i,:));
end
histogram(numLinks)

