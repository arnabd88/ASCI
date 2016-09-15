
IterNF = @(x) x + log(x)

Z = [0.1:0.001:1]
FuncVec = IterNF(Z)
plot(Z, FuncVec, 'b', Z, zeros(1,length(Z)))
hold on
plot(Z, -log(Z), 'r', Z, zeros(1,length(Z)))
hold on
plot(Z, Z, 'r', Z, zeros(1,length(Z)))
hold on
plot(Z, exp(-Z), 'g', Z, zeros(1,length(Z)))
xlabel('X')
ylabel('X + ln(X)')
