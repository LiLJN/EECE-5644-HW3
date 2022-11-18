function [x,labels] = generate(N,classPriors,w0,mu0,Sigma0,mu1,Sigma1)
figure,
%classPriors = [0.6,0.4];
labels = (rand(1,N) >= classPriors(1));
data = zeros(2,N);
for l = 0:1
    indl = find(labels==l);
    if l == 0
        N0 = length(indl);
%         w0 = [0.5,0.5]; mu0 = [5 0;0 4];
%         Sigma0(:,:,1) = [4 0;0 2]; Sigma0(:,:,2) = [1 0;0 3];
        gmmParameters.priors = w0; % priors should be a row vector
        gmmParameters.meanVectors = mu0;
        gmmParameters.covMatrices = Sigma0;
        [x(:,indl),components] = generateDataFromGMM(N0,gmmParameters);
        plot(x(1,indl),x(2,indl),'b.'), hold on, 
        %plot(x(1,indl(components==2)),x(2,indl(components==2)),'b.'), hold on, 
        
        
    elseif l == 1
        %m1 = [3;2]; C1 = eye(2).*2;
        N1 = length(indl);
        x(:,indl) = mvnrnd(mu1,Sigma1,N1)';
        data(:,labels==1) = x(:,indl);
        plot(x(1,indl),x(2,indl),'r.'), hold on,
        axis equal,
    end
end

title('Class 0 and Class 1 Class Labels using $\mathcal{D}_{train}^{100}$','Interpreter','latex')
xlabel('$x$','interpreter','latex')
ylabel('$y$','interpreter','latex')
legend('$p(\mathbf{x}|L=0)$','$p(\mathbf{x}|L=1)$','interpreter','latex')