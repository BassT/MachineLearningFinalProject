function [ target ] = transformClassesToNNTargetVector( classes )

target = zeros(size(classes));

for i = 1:size(classes,2)
    target(classes(i),i) = 1;
end

end

