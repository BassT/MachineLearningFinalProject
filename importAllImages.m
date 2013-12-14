dataset = zeros(3410,24*24);
datasetBW = zeros(3410,24*24);

tic;
for sample = 1:62
    disp(strcat('Importing sample ', num2str(sample)));
    for img = 1:55
        currentImgString = strcat('img', num2str(sample,'%03d'), '-', ...
            num2str(img,'%03d'), '.png');
        currentImg = imread(currentImgString);
        currentImg = rgb2gray(currentImg);
        [t,b,l,r] = findBorders(im2double(currentImg));
        currentImg = currentImg(t:b,l:r);
%         figure;image(currentImg);colormap gray
        threshhold = graythresh(currentImg);
        currentImgBW = im2bw(currentImg, threshhold);
        currentImg = imresize(currentImg, [24 24]);
        currentImgBW = imresize(currentImgBW, [24 24]);
%         figure;image(currentImg);colormap gray
        dataset((sample - 1) * 55 + img,:) = reshape(currentImg,1,24*24);
        datasetBW((sample - 1) * 55 + img,:) = reshape(currentImgBW,1,24*24);
    end
    toc;
end

% let's transpose it so any column contains stacked columns of one image
dataset = dataset';
datasetBW = datasetBW';