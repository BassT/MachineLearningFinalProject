function [ residuals ] = computeResidualsTest( dataset, x, y )
%computeResidualsTest Computes the residuals (test-wise)

%test-wise assume first sample of first class is the test sample

residuals = zeros(62,1);

for i = 1:62
    if i == 1
        residuals(i) = norm(y - [dataset(:,1:54) ...
            zeros(size(dataset,1),size(dataset(:,55:end),2))] * x);
    elseif i == 62
        delta_i = [zeros(size(dataset,1),3354) dataset(:,3355:end)];
        residuals(i) = norm(y - delta_i * x);
    else
        delta_i = [zeros(size(dataset,1),(i-1)*55 - 2) ...
            dataset(:,(i-1)*55:i*55) zeros(size(dataset,1),(62-i)*55)];
        residuals(i) = norm(y - delta_i * x);
    end
    
end
end

