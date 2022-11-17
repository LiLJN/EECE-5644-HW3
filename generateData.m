function [x,labels] = generateData(N)
figure(1), clf,
classPriors = [0.6,0.4];
labels = (rand(1,N) >= classPriors(1));
data = zeros(2,N);
for l = 0:1
    indl = find(labels==l);
    if l == 0
        N0 = length(indl);
        w0 = [0.5,0.5]; mu0 = [5 0;0 4];
        Sigma0(:,:,1) = [4 0;0 2]; Sigma0(:,:,2) = [1 0;0 3];
        gmmParameters.priors = w0; % priors should be a row vector
        gmmParameters.meanVectors = mu0;
        gmmParameters.covMatrices = Sigma0;
        [x(:,indl),components] = generateDataFromGMM(N0,gmmParameters);
        plot(x(1,indl),x(2,indl),'b.'), hold on, 
        %plot(x(1,indl(components==2)),x(2,indl(components==2)),'b.'), hold on, 
        
        
    elseif l == 1
        m1 = [3;2]; C1 = eye(2).*2;
        N1 = length(indl);
        x(:,indl) = mvnrnd(m1,C1,N1)';
        data(:,labels==1) = x(:,indl);
        plot(x(1,indl),x(2,indl),'r.'), hold on,
        axis equal,
    end
end
title('Class 0 and Class 1 True Class Labels for 100 samples')
xlabel('$x$','interpreter','latex')
ylabel('$y$','interpreter','latex')
legend('$p(\mathbf{x}|L=0)$','$p(\mathbf{x}|L=1)$','interpreter','latex')
title('Class 0 and Class 1 True Class Labels for 20000 samples')

%%%
function [x,labels] = generateDataFromGMM(N,gmmParameters)
% Generates N vector samples from the specified mixture of Gaussians
% Returns samples and their component labels
% Data dimensionality is determined by the size of mu/Sigma parameters
priors = gmmParameters.priors; % priors should be a row vector
meanVectors = gmmParameters.meanVectors;
covMatrices = gmmParameters.covMatrices;
n = size(gmmParameters.meanVectors,1); % Data dimensionality
C = length(priors); % Number of components
x = zeros(n,N); labels = zeros(1,N); 
% Decide randomly which samples will come from each component
u = rand(1,N); thresholds = [cumsum(priors),1];
for l = 1:C
    indl = find(u <= thresholds(l)); Nl = length(indl);
    labels(1,indl) = l*ones(1,Nl);
    u(1,indl) = 1.1*ones(1,Nl); % these samples should not be used again
    x(:,indl) = mvnrnd(meanVectors(:,l),covMatrices(:,:,l),Nl)';
end