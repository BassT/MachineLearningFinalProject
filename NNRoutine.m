% Solve a Pattern Recognition Problem with a Neural Network
% Script generated by NPRTOOL
% Created Fri Dec 13 22:56:37 EST 2013
%
% This script assumes these variables are defined:
%
%   datasetBW - input data.
%   target - target data.

load('datasetBW.mat');
load('target.mat');

inputs = datasetBW;
targets = transformClassesToNNTargetVector(target);

error_rate = ones(20,1);

for i = 1:20
    
    % Create a Pattern Recognition Network
    hiddenLayerSize = 80;
    net = patternnet(hiddenLayerSize);
    
    
    % Setup Division of Data for Training, Validation, Testing
    net.divideParam.trainRatio = 80/100;
    net.divideParam.valRatio = 10/100;
    net.divideParam.testRatio = 10/100;
    net.divideFcn = 'divideint';
    
    % Train the Network
    tic;
    [net,tr] = train(net,inputs,targets);
    toc;
    
    % Test the Network
    outputs = net(inputs);
    output_target = maxOnly(outputs)';
    
%     error_rate = length(find(output_target ~= classes_of_train_data))/3410;
    
    % compute error rate
    error_rate(i) = length(find(output_target ~= classes_of_train_data))/3410;
    
    % if current net has best error rate, save net
    if(error_rate(i) == min(error_rate(i)))
        best_net = net;
    end
    
end