clear all
clc
close all

load manoj
load Sanjeev
load im2
load im4
a = [im4(1:2) im2(1:2)];
x = [im4(3) im4(3) im2(3) im2(3)];
 
% net_fffbp = network;
net_fffbp = newff(a,x,[25],{'tansig'});
net_fffbp.trainParam.epochs = 100; %Maximum number of epochs to train
net_fffbp.trainParam.show = 25; %Epochs between displays (NaN for no displays)
net_fffbp.trainParam.showCommandLine = 0; %Generate command-line output
net_fffbp.trainParam.showWindow = 1; %Show training GUI
net_fffbp.trainParam.goal  = 1e-5; %Performance goal
net_fffbp.trainParam.time = inf; %Maximum time to train in seconds
net_fffbp.trainParam.min_grad  = 1e-6; %Minimum performance gradient
net_fffbp.trainParam.max_fail = 5; %Maximum validation failures
net_fffbp.trainParam.sigma = 5.0e-5; %Determine change in weight for second derivative approximation
net_fffbp.trainParam.lambda = 5.0e-7; %Parameter for regulating the indefiniteness of the Hessian


[net_fffbp, tr ] = train(net_fffbp,a,x);
[net_fffbp,Y,E ] = adapt(net_fffbp,a,x);

a = [Manoj(1:2) Sanjeev(1:2)];
[~, Y1,~] =  adapt(net_fffbp,a);
Y1 = round(Y1)
Y = round(Y)
if isequal(Y,Y1)
    disp('RT');
else
    disp('ok');
end
Err = round(E)
% save net_fffbp net_fffbp
