load('dataset.mat');

% generate training set class vector
classes_of_train_data = zeros(1,size(dataset,2));
for i = 1:size(dataset,2)
    classes_of_train_data(i) = ceil(i/55 - 0.001);
end

% randomly select r test samples
r = 20;
test_indices = randi(size(dataset,2),r,1);

classes_of_test_samples = zeros(1,r);
test = zeros(size(dataset,1),r);
train = dataset;

% add samples to test vector
for i = 1:r
    % add sample to test set
    test(:,i) = dataset(:,test_indices(i));
    
    % add class of added test sample to test sample class vector
    classes_of_test_samples(i) = classes_of_train_data(test_indices(i));
end

% remove samples from training sets
for i = 1:r
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
    x = l1qc_logbarrier(zeros(size(train,2),1), train, [], test(:,i), 0.05);
%     x = l1eq_pd(zeros(size(train,2),1), train, [], test(:,i));
%     x = SolveOMP(train, test(:,i), size(train,2), 10*size(train,1)); 
%     x = SolveLasso(train, test(:,i), size(train,2), 'lasso',10*size(train,1));

    [res, recoveredImage] = computeResiduals(train, x, test(:,i), classes_of_train_data, 0);
    class(i) = find(res == min(res),1);
    
    t = toc(ticid);
    fprintf('finished after %d.\n',t);
    
    % compare recovered and original image if error
    if (class(i) ~= classes_of_test_samples(i))
        
        disp(strcat('I thought this ''',labels(classes_of_test_samples(i)),''' was a ''',labels(class(i)),''''));
        figure('name',strcat('solution for ',num2str(i),'th test sample'));plot(x);
        figure('name',strcat('residuals for ',num2str(i),'th test sample'));plot(res);
        figure('name','recovered image');image(reshape(recoveredImage,24,24));colormap gray;
        figure('name','original image');image(reshape(test(:,i),24,24));colormap gray;
        
    end
    
end

for i = 1:r
    if (class(i) ~= classes_of_test_samples(i))
        error = error + 1;
    end
end

% matlabpool close;
