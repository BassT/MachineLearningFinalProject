dataset = zeros(3410,10800);

tic;
for sample = 1:62
    disp(strcat('Importing sample ', num2str(sample)));
    for img = 1:55
        currentImgString = strcat('img', num2str(sample,'%03d'), '-', ...
            num2str(img,'%03d'), '.png');
        currentImg = imread(currentImgString);
        currentImg = imresize(currentImg, 0.1);
        currentImg = rgb2gray(currentImg);
        dataset((sample - 1) * 55 + img,:) = reshape(currentImg,1,10800);
    end
    toc;
end