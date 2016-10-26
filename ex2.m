function asdf = ex2()

load('dataAEX.mat');
load('labelsAEX.mat')


Y = pdist(data);

Z = linkage(Y,'complete')

[H,T] = dendrogram(Z,'Labels',labels);


end