function [ top, bottom, left, right ] = findBorders( image )
%findBorders Detects the outer pixels that are non-white

% top border
for i = 1:size(image,1)
    if(any(image(i,:)==0))
        top = i;
        break;
    end
end

% bottom border
for i = 1:size(image,1)
    if(any(image((size(image,1) - i),:)==0))
        bottom = (size(image,1) - i);
        break;
    end
end

% left border
for i = 1:size(image,2)
    if(any(image(:,i)==0))
        left = i;
        break;
    end
end

% right border
for i = 1:size(image,2)
    if(any(image(:,size(image,2) - i)==0))
        right = size(image,2) - i;
        break;
    end
end

end

