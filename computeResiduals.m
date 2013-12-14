function [ residuals, recovery ] = computeResiduals( A, x, y, target, removed_samples )
%computeResiduals

residuals = zeros(62 - removed_samples,1);
for class = removed_samples+1:62
    % find indices of the columns that shall be set to zero
    indices = find(target ~= class);
    
    % generate delta_i with only non zero entries for columns of current
    % class
    delta_i = A;
    for i = indices
        delta_i(:,i) = zeros(size(A,1),1);
    end
    
    recoveredImage = delta_i * x;
    
    % compute residual for y
    residuals(class - removed_samples) = norm(y - recoveredImage);
    
    if(class == removed_samples+1)
        current_min_res = residuals(class - removed_samples);
    end
    
    if(residuals(class - removed_samples) < current_min_res)
        current_min_res = residuals(class - removed_samples);
        recovery = recoveredImage;
    end
    
end

% figure('name','recovered image');image(reshape(recovery,24,24));colormap gray;
% figure('name','original image');image(reshape(y,24,24));colormap gray;

end

