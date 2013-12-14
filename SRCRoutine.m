load('dataset.mat');
load('target.mat');

% randomly move 10 samples of each class to test set
[ train_data, train_target, test_data, test_target ] = splitDataset( dataset, target );

% set output vector
output = zeros(1,size(test_data,2));

% try to classify each test sample
for i = 1:size(test_data,2)
    
    ticid = tic;
    fprintf('Started working on test sample %d (''%s'')...',i,labels(test_target(i)));
    % find sparsest representation of test sample
    x = l1eq_pd(zeros(size(train_data,2),1), train_data, [], test_data(:,i));
%     x = l1qc_logbarrier(zeros(size(train_data,2),1), train_data, [], test_data(:,i), 0.05);
    
    % compute class residuals
    res = computeResiduals(train_data, x, test_data(:,i), train_target, 0);
    
    % classify based on residuals
    output(i) = find(res == min(res),1);
    fprintf('finished after %d, identified as ''%s''\n',toc(ticid),labels(output(i)));
    
end

% compute error rate
error_rate = length(find(output ~= test_target))/size(test_target,2);