function  props = getRegionProps(source, inputIm)
%灰度反转，提取图像特征
[nrow, ncol] = size(source);
result = 255 - source;
bwImage = im2bw(result, 0);

[L, num] = bwlabel(bwImage, 8);

stats = regionprops(L, 'all');
temp = zeros(nrow, ncol);

for i = 1 : nrow
    for j = 1 : ncol
        if L(i, j) ~= 0
            temp(i, j) = source(i, j);
        else
            temp(i, j) = -1;
        end
    end
end

se = strel('disk', 5);
erodeIm = uint8(imerode(source, se));
erodeIm = 255 - erodeIm;
bwErodeIm = im2bw(erodeIm, 0);

erodeTemp = zeros(nrow, ncol);
for i = 1 : nrow
    for j = 1 : ncol
        if 0 ~= bwErodeIm(i, j)
            erodeTemp(i, j) = inputIm(i, j);
        else
            erodeTemp(i, j) = -1;
        end
    end
end

count = 0;
for i = 1 : num
    area = stats(i).Area;
    if area < 7
        continue;
    end
    %计算灰度
    locate = stats(i).Centroid;
    
%     dme = getDME(temp, erodeTemp, uint32(locate(1)), uint32(locate(2)), area);
%     if dme < 0
%        continue; 
%     end
    count = count + 1;
%     props(count, 6) = dme;
    
    %计算其他属性
    props(count, 1) = stats(i).Solidity; 
    props(count, 2) = stats(i).Eccentricity;
    props(count, 3) = stats(i).MajorAxisLength / stats(i).MinorAxisLength;
    props(count, 4) = stats(i).Orientation;   
    props(count, 5) = abs(locate(2) - nrow / 2) / nrow;
    props(count, 7) = locate(1);
    props(count, 8) = locate(2);
end