function [ output ] = maxOnly( input )

output = zeros(size(input,2),1);

% for each sample
for i = 1:size(input,2)
    % find most likeliest class and set to its row index
    index = find(input(:,i) == max(input(:,i)));
    output(i) = index;
end

