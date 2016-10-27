function [decisionCriterion, mc1, mc2] = ex1()

load('normdist(1).mat');

%plot S1 and S2
figure(1);
plot(S1, zeros(length(S1),1), 'bo');
hold on;
plot(S2, zeros(length(S2),1), 'ro');
hold on;
plot(T, zeros(length(T),1), 'ks');
legend('S1','S2','T');
set(gca, 'YTick', 0:0:0);
set(gca, 'YTickLabel', {'','',''});
axis([-40 80 -0.1 0.1]);

%plot gaussian functions
figure(2);

plot(S1, zeros(length(S1),1), 'bo');
hold on;
plot(S2, zeros(length(S2),1), 'ro');

maxEst=mle(S1);
muS1=maxEst(1);
sgS1=maxEst(2);
xS1=linspace(muS1-4*sgS1,muS1+4*sgS1,200);
pdfS1=1/sqrt(2*pi)/sgS1*exp(-(xS1-muS1).^2/(2*sgS1^2));
plot(xS1,pdfS1,'b');
axis([-80 100 0 0.04]);

maxEst=mle(S2);
muS2=maxEst(1);
sgS2=maxEst(2);
xS2=linspace(muS2-4*sgS2,muS2+4*sgS2,200);
pdfS2=1/sqrt(2*pi)/sgS2*exp(-(xS2-muS2).^2/(2*sgS2^2));
plot(xS2,pdfS2,'r');

legend('S1','S2');

%calculate prior probabilities
P_1 = length(S1)/(length(S1) + length(S2));
P_2 = length(S2)/(length(S1) + length(S2));

%plot probabilities multiplied by prior probabilities
figure(3)

plot(S1, zeros(length(S1),1), 'bo');
hold on;
plot(S2, zeros(length(S2),1), 'ro');
plot(T, zeros(length(T),1), 'ks');



legend('S1','S2','T');

%solve the equation
syms x;
a = solve(1/(sqrt(2*pi)*sgS1)*exp(-(x-muS1).^2/(2*sgS1^2))*P_1 == 1/(sqrt(2*pi)*sgS2)*exp(-(x-muS2).^2/(2*sgS2^2)) * P_2, x);
decisionCriterion = eval(a);
decisionCriterion = decisionCriterion(1);

mc1 = sum(S1>decisionCriterion);
mc2 = sum(S2<=decisionCriterion);

%plot the lines
x = [decisionCriterion decisionCriterion];
y = [0 0.014];
plot(x,y,'g');
plot(xS1,pdfS1.*P_1, 'b');
plot(xS2,pdfS2.*P_2, 'r');
legend('S1','S2','T','Decision Criterion')
end
