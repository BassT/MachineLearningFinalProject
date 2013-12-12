function [ error_rate ] = runSolveLasso( test, train, target, lambda, fold )
%runSolveLasso Computes error rate of Lasso algorithm for classifying
%chars.

correct = 0;
wrong = 0;

for i = 1:size(test,2)
    
    ticid = tic;
    
    sols = SolveLasso(train, test(:,i), ...
        size(train,2), 'lasso', 10*size(train,1), lambda);
    
    res = computeResidualsFor11FoldCV(train,sols,test);
    
    if (classify(res) == target(i))
        correct = correct + 1;
    else
        wrong = wrong + 1;
    end
    t = toc(ticid);
    disp(strcat('runSolveLassoFold', num2str(fold), ':', num2str(i) ,'/',num2str(size(test,2)),'...finished...',num2str(t)));
    
end

error_rate = wrong/(wrong+correct);

end

