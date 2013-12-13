load('dataset.mat');

% randomly select r test samples
r = 20;
test_indices = randi(size(dataset,2),r,1);

target = zeros(1,r);
test = zeros(size(dataset,1),r);
train = dataset;

for i = 1:r
    % add sample to test set
    test(:,i) = dataset(:,test_indices(i));
    
    % generate target vector (e.g. the 154 columns represents a sample of
    % the third class (number 2))
    target(i) = ceil(test_indices(i)/55);
    
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
    fprintf('Starting l1-minimization for %dth test sample...',i);
%     x = l1qc_logbarrier(zeros(size(train,2),1), train, [], test(:,i), 0.05);
%     x = l1eq_pd(zeros(size(train,2),1), train, [], test(:,i));
%     x = SolveOMP(train, test(:,i), size(train,2), 10*size(train,1));
    x = SolveLasso(train, test(:,i), size(train,2), 'lasso', 10*size(train,1));
    
    res = computeResiduals(train, x, test(:,i), target, 62);
    
    class(i) = find(res == min(res),1);
    
    t = toc(ticid);
    fprintf('finished after %d.\n',t);
    
end

for i = 1:r
    if (class(i) ~= target(i))
        error = error + 1;
    end
end

% matlabpool close;
