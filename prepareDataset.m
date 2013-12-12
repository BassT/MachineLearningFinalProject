function [test, train, target] = prepareDataset( dataset, fold )
target = zeros(1,62*5);
test = zeros(size(dataset,1),62*5);
train = zeros(size(dataset,1),62*50);
% prepare dataset for cross validation
for class = 1:62
    target((class - 1)*5 + 1:class*5) = class;
    
    % take the ith five samples of each class as test samples for the
    % ith fold
    test_start_col = (class - 1)*55 + (fold - 1)*5 + 1;
    test_end_col = (class - 1)*55 + fold*5;
    test(:,(class - 1)*5 + 1:class*5) = dataset(:,test_start_col:test_end_col);
    
    % take the the remaining 55 samples of each class as train samples
    train_start_col = (class - 1)*55 + 1;
    train_end_col = class*55;
    train(:,(class - 1)*50 + 1:class*50) = ...
        dataset(:,[train_start_col:(test_start_col - 1),(test_end_col + 1):train_end_col]);
end
end