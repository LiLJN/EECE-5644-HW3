N=20000;

[x4, labels4] = generateData(N);
save('prob4_data.mat', 'x4', 'labels4'); 

load('prob4_data.mat');
x4 = x4';
labels4 = labels4';
%k = KernelPca(x4, 'gaussian','gamma',10,'AutoScale', true);
M = 2;
projected_X = project(k, x4, M);
figure(2);
hold on;
gscatter(projected_X(:, 1), projected_X(:, 2), labels4);
title('pca with gaussian kernel');
xlabel('principal dim');
ylabel('second dim');

L0 = projected_X(:,1);
L1 = projected_X(:,2);
Lratio = (L1 ./ L0)';
classPriors = [0.6,0.4];
gamma_bayes = classPriors(1)/classPriors(2);
labels_bayes = (Lratio >= gamma_bayes)';

[Xroc, Yroc, Troc, AUC] = perfcurve(labels4, Lratio, 1);
figure(3);
clf;
hold on;
plot(Xroc, Yroc);
scatter(FPR_bayes, TPR_bayes, 100, [0, 0.8, 0], 'filled');
scatter(FPR_emp, TPR_emp, 100, [0.7, 0.0, 0], 'filled');
legend({'ROC curve', 'Bayes Threshold', 'Empirical Threshold'}, 'location', 'southeast')
xlim([0,1])
ylim([0,1])
xlabel('False Positive Rate')
ylabel('True Positive Rate')
title('ROC for Likelihood-Thresholding')



