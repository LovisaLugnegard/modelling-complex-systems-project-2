
function networkMatrix = createRanSocNet(N,d)
networkMatrix = zeros(N);
for i = 1:N
    for j = i+1:N
        r = rand;
        if(r<=d)
            networkMatrix(i,j) = 1;
            networkMatrix(j,i) = 1;
        end
    end
end
end