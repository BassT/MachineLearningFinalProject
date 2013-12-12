function [ class ] = classifyN( residuals, n )
index = find(residuals == min(residuals(:)));
class = ceil(index/n);
end

