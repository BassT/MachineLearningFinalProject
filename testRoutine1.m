load('dataset.mat');

matlabpool local 3;

error_rate = zeros(11,1);
parfor fold = 1:11
% for fold = 1:11
    
    ticid = tic;
    disp(strcat('Started fold:', num2str(fold)));
    [test, train, target] = prepareDataset( dataset, fold );
    
    error_rate(fold) = runSolveLasso(test, train, target, 1, fold); % high lambda
%     error_rate(fold) = runSolveLasso(test, train, target, 0.1, fold); % medium lambda
%     error_rate(fold) = runSolveLasso(test, train, target, 0.01, fold); % small lambda
    
    disp(strcat('Finished fold:', num2str(fold),'...',num2str(toc(ticid))));
    
end

matlabpool close;