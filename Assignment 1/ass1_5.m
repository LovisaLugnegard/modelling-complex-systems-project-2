
k = 0:1/1000:2;
y = zeros(1,length(k));
for i=1:length(k)
y(i) = 1/(k(i)*(k(i)+1)*(k(i)+2));
end
loglog(k,y)
xlabel('log(k)')
ylabel('log(n_k), long time constant')
