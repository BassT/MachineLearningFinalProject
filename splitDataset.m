function [ train_data, train_target, test_data, test_target ] = splitDataset( input, target )

currentCol = 1;

% split each class
for class = 1:62
    % take only columns of current class
    data_subset = input(:,(class - 1)*55 + 1:class*55);
    target_subset = target(:,(class - 1)*55 + 1:class*55);
    
    % randomly add 10 samples of the subsets to the test set
    r = 10;
    test_indices = randi(size(data_subset,2),r,1);
    for i = 1:r
        test_data(:,(class - 1) * r + i) = data_subset(:,test_indices(i));
        test_target((class - 1) * r + i) = target_subset(test_indices(i));
    end
    
    % add remaining samples to training set
    for j = 1:size(data_subset,2)
        if(ismember(j,test_indices) == 0)
            train_data(:,currentCol) = data_subset(:,j);
            train_target(:,currentCol) = target_subset(:,j);
            currentCol = currentCol + 1;
        end
    end
    
end

end

