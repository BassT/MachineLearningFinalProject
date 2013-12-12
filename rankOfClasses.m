function [ ranks ] = rankOfClasses( dataset )
%rankOfClasses Computes the rank for each class of the dataset

ranks = zeros(62,1);

for sample = 1:62
    ranks(sample) = rank(dataset(:,((sample - 1) * 55 + 1):(sample * 55)));
end

end