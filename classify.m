function [ class ] = classify( residuals )
%classify Classifies based on residuals

index = find(residuals == min(residuals(:)));

class = ceil(index/5);

end

