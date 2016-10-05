function f = one()

load('normdist(1).mat');


figure(1);
plot(S1, zeros(length(S1)), 'bo');
hold on;
plot(S2, zeros(length(S2)), 'ro');
hold on;
plot(T, zeros(length(T)), 'ks');
set(gca, 'YTick', 0:0:0);
set(gca, 'YTickLabel', {'','',''});
axis([-40 80 -0.1 0.1]);

figure(2);
maxEst=mle(S1);
muS1=maxEst(1);
sgS1=maxEst(2);
xS1=linspace(muS1-4*sgS1,muS1+4*sgS1,200);
pdfS1=1/sqrt(2*pi)/sgS1*exp(-(xS1-muS1).^2/(2*sgS1^2));
plot(xS1,pdfS1,'b');
axis([-80 100 0 0.04]);

hold on;

maxEst=mle(S2);
muS2=maxEst(1);
sgS2=maxEst(2);
xS2=linspace(muS2-4*sgS2,muS2+4*sgS2,200);
pdfS2=1/sqrt(2*pi)/sgS2*exp(-(xS2-muS2).^2/(2*sgS2^2));
plot(xS2,pdfS2,'r');

plot(S1, zeros(length(S1)), 'bo');
plot(S2, zeros(length(S2)), 'ro');

P_1 = length(S1)/(length(S1) + length(S2));
P_2 = length(S2)/(length(S1) + length(S2));

figure(3)

plot(xS1,pdfS1.*P_1, 'b');
hold on;
plot(xS2,pdfS2.*P_2, 'r');

plot(S1, zeros(length(S1)), 'bo');
plot(S2, zeros(length(S2)), 'ro');
plot(T, zeros(length(T)), 'ks');

syms x;
solve(1/sqrt(2*pi)/sgS1*exp(-(x-muS1).^2/(2*sgS1^2))*P_1 == 1/sqrt(2*pi)/sgS2*exp(-(x-muS2).^2/(2*sgS2^2)) * P_2, x==0, x)



end