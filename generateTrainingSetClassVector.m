% generate training set class vector
classes_of_train_data = zeros(1,size(dataset,2));
for i = 1:size(dataset,2)
    classes_of_train_data(i) = ceil(i/55 - 0.001);
end