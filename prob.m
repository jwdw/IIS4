function output = prob(x, mu, sg)

output = 1/sqrt(2*pi)/sg*exp(-(x-mu).^2/(2*sg^2));