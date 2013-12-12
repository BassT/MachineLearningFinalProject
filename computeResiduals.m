function [ residuals ] = computeResiduals( A, x, y, target )
%computeResiduals

classes = 62;
residuals = zeros(classes,1);
for class = 1:classes
    % find indices of the columns that shall be set to zero
    indices = find(target ~= class);
    
    % generate delta_i with only non zero entries for columns of current
    % class
    delta_i = A;
    for i = indices
        delta_i(:,i) = zeros(size(A,1),1);
    end
    
    % compute residual for y
    residuals(class) = norm(y - delta_i * x);
end

end

