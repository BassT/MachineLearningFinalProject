load('dataset.mat');

% generate training set class vector
classes_of_train_data = zeros(1,size(dataset,2));
for i = 1:size(dataset,2)
    classes_of_train_data(i) = ceil(i/55 - 0.001);
end

% remove numbers from dataset
number_of_samples_to_remove = 10;
dataset_no_numbers = dataset(:,number_of_samples_to_remove*55:end);
classes_of_train_data = classes_of_train_data(:,number_of_samples_to_remove*55:end);

% randomly select r test samples
r = 20;
test_indices = randi(size(dataset_no_numbers,2),r,1);

classes_of_test_samples = zeros(1,r);
test = zeros(size(dataset_no_numbers,1),r);
train = dataset_no_numbers;

for i = 1:r
    % add sample to test set
    test(:,i) = dataset_no_numbers(:,test_indices(i));
    
    % add class of added test sample to test sample class vector
    classes_of_test_samples(i) = classes_of_train_data(test_indices(i));
    
    % remove class of added test sample to training sample class vector
    classes_of_train_data(i) = [];
    
    % remove test samples from training set
    train(:,i) = [];
end


% compute error rate
error = 0;
class = zeros(1,r);

% matlabpool local 2;

% parfor i = 1:r
for i = 1:r
    
    ticid = tic;
    fprintf('Starting l1-minimization for %dth test sample (class %d)...',i,classes_of_test_samples(i));
%     x = l1qc_logbarrier(zeros(size(train,2),1), train, [], test(:,i), 0.05);
    x = l1eq_pd(zeros(size(train,2),1), train, [], test(:,i));
%     x = SolveOMP(train, test(:,i), size(train,2), 10*size(train,1));
%     x = SolveLasso(train, test(:,i), size(train,2), 'lasso', 10*size(train,1));

%     figure('name',strcat('solution for ',num2str(i),'th test sample'));plot(x)
    
    res = computeResiduals(train, x, test(:,i), classes_of_train_data, number_of_samples_to_remove);
    
    scale = (10:61);
    
    figure('name',strcat('residuals for ',num2str(i),'th test sample'));plot(scale, res)
    
    class(i) = find(res == min(res),1) + number_of_samples_to_remove;
    
    t = toc(ticid);
    fprintf('finished after %d.\n',t);
    
end

for i = 1:r
    if (class(i) ~= classes_of_test_samples(i))
        error = error + 1;
    end
end

% matlabpool close;
