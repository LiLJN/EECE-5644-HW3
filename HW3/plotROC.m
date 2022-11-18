function [FPR,TPR] = plotROC(x,labels,p,w,m01,C01,m02,C02,m1,C1)
    disScore = log(evalGaussian(x,m1,C1)./(w(1)*evalGaussian(x,m01,C01)+w(2)*evalGaussian(x,m02,C02)));
    %gamma = sort(disScore(disScore>=0));
    %tau = log(gamma);
    %Generate vector of threshold for parametric sweep
    tau = log(sort(disScore(disScore>=0)));
    %Make decision for every threshold and calculate error values
    for i = 1:length(tau)
    decision = disScore >= tau(i);
    FPR(i) = sum(decision==1 & labels==0)/length(find(labels==0));
    TPR(i) = sum(decision==1 & labels==1)/length(find(labels==1));
    P_error(i) = FPR(i)*p(1)+(1-TPR(i))*p(2);
    end
    %Find minimum error and corresponding threshold
    [min_error,min_index] = min(P_error);
    min_decision = (disScore >= tau(min_index));
    min_FPR = FPR(min_index);
    min_TPR = TPR(min_index);
    theo_decision = disScore>=log(p(1)/p(2));
    theo_FPR = sum(theo_decision==1 & labels==0)/length(find(labels==0));
    theo_TPR = sum(theo_decision==1 & labels==1)/length(find(labels==1));
    theo_error = theo_FPR*p(1)+(1-theo_TPR)*p(2);
    figure;
    plot(FPR,TPR);
    %plot(FPR,TPR,'-',min_FPR,min_TPR,'o',theo_FPR,theo_TPR,'g+');
    title('ROC Curve');
    %legend('ROC Curve','Calculated Min Error','Theoretical Min Error');
    legend('ROC Curve')
    xlabel('FPR');
    ylabel('TPR');
end

function G_pdf = evalGaussian(x,mu,Sigma)
    [n,N] = size(x);
    term1 = (det(Sigma)*(2*pi)^n)^(-1/2);
    term2 = (-1/2)*sum((x-repmat(mu,1,N)).*(inv(Sigma)*(x-repmat(mu,1,N))),1);
    G_pdf = term1*exp(term2);
end