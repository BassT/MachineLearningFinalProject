function [ output ] = normalizeColumns( input )
%normalizeColumns Normalizes each column to have a unit l2-norm

for i = 1:size(input,2)
    output(:,i) = input(:,i)./ norm(input(:,i),2);
end

end

