N1 = 10000;
[X1,X1x00,X1x01,X1x0,X1x1,X1label] = generate_sep_Data(N1);
N2 = 1000;
[X2,X2x00,X2x01,X2x0,X2x1,X2label] = generate_sep_Data(N2);
N3 = 100;
[X3,X3x00,X3x01,X3x0,X3x1,X3label] = generate_sep_Data(N3);

priorX1x0 = length(X1x0)/length(X1);
priorX1x1 = length(X1x1)/length(X1);
priorX2x0 = length(X2x0)/length(X2);
priorX2x1 = length(X2x1)/length(X2);
priorX3x0 = length(X3x0)/length(X3);
priorX3x1 = length(X3x1)/length(X3);

X1m01 = mean(X1x00,2);
X1m02 = mean(X1x01,2);
X1m1 = mean(X1x1,2);
X1m0 = [X1m01 X1m02];
X2m01 = mean(X2x00,2);
X2m02 = mean(X2x01,2);
X2m1 = mean(X2x1,2);
X2m0 = [X2m01 X2m02];
X3m01 = mean(X3x00,2);
X3m02 = mean(X3x01,2);
X3m1 = mean(X3x1,2);
X3m0 = [X3m01 X3m02];

X1v01 = mean((X1x00-X1m01)*(X1x00-X1m01)',2)/length(X1x00);
X1v02 = mean((X1x01-X1m02)*(X1x01-X1m02)',2)/length(X1x01);
X1v1 = mean((X1x1-X1m1)*(X1x1-X1m1)',2)/length(X1x1);
X2v01 = mean((X2x00-X2m01)*(X2x00-X2m01)',2)/length(X2x00);
X2v02 = mean((X2x01-X1m02)*(X2x01-X2m02)',2)/length(X2x01);
X2v1 = mean((X2x1-X1m1)*(X2x1-X1m1)',2)/length(X2x1);
X3v01 = mean((X3x00-X3m01)*(X3x00-X3m01)',2)/length(X3x00);
X3v02 = mean((X3x01-X3m02)*(X3x01-X3m02)',2)/length(X3x01);
X3v1 = mean((X3x1-X3m1)*(X3x1-X3m1)',2)/length(X3x1);

X1c01 = diag(X1v01);
X1c02 = diag(X1v02);
X1c1 = diag(X1v1);
X1c0(:,:,1) = X1c01;
X1c0(:,:,2) = X1c02;
X2c01 = diag(X2v01);
X2c02 = diag(X2v02);
X2c1 = diag(X2v1);
X2c0(:,:,1) = X2c01;
X2c0(:,:,2) = X2c02;
X3c01 = diag(X3v01);
X3c02 = diag(X3v02);
X3c1 = diag(X3v1);
X3c0(:,:,1) = X3c01;
X3c0(:,:,2) = X3c02;

X1w0 = length(X1x00)/length(X1x0);
X1w1 = length(X1x01)/length(X1x0);
classPriorsX1 = [priorX1x0,priorX1x1];
X1w = [X1w0,X1w1];
X2w0 = length(X2x00)/length(X2x0);
X2w1 = length(X2x01)/length(X2x0);
classPriorsX2 = [priorX2x0,priorX2x1];
X2w = [X2w0,X2w1];
X3w0 = length(X3x00)/length(X3x0);
X3w1 = length(X3x01)/length(X3x0);
classPriorsX3 = [priorX3x0,priorX3x1];
X3w = [X3w0,X3w1];

N = 20000;
[XN1,XN1label] = generate(N,classPriorsX1,X1w,X1m0,X1c0,X1m1,X1c1);
[FPRN1,TPRN1] = plotROC(XN1,XN1label,classPriorsX1,X1w,X1m01,X1c01,X1m02,X1c02,X1m1,X1c1);

[XN2,XN2label] = generate(N,classPriorsX2,X2w,X2m0,X2c0,X2m1,X2c1);
[FPRN2,TPRN2] = plotROC(XN2,XN2label,classPriorsX2,X2w,X2m01,X2c01,X2m02,X2c02,X2m1,X2c1);
 
[XN3,XN3label] = generate(N,classPriorsX3,X3w,X3m0,X3c0,X3m1,X3c1);
[FPRN3,TPRN3] = plotROC(XN3,XN3label,classPriorsX3,X3w,X3m01,X3c01,X3m02,X3c02,X3m1,X3c1);