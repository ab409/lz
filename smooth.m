function smoothImage = smooth(grayImage, factorSize)

[width, height] = size(grayImage);
doublesmoothImage = zeros(width, height);
 halfSize = floor(factorSize/2);
for i = 1 : width
    for j = 1 : height
       %����X��ʼ����ֹ����
       if i - halfSize < 1
           startX = 1;
       else
           startX = i - halfSize;
       end
       if i + halfSize > width
           endX = width;
       else
           endX = i + halfSize;
       end
       %����Y��ʼ����ֹ����
       if j - halfSize < 1
          startY = 1;
       else
          startY = j - halfSize;
       end
       if j + halfSize > height
           endY = height;
       else
           endY = j + halfSize;
       end
       %����15*15ģ���ֵ
       sumValue = sum(sum(grayImage(startX:endX, startY:endY)));
       count = (endX + 1 - startX) * (endY + 1 - startY);
       doublesmoothImage(i, j) = sumValue / count;
    end
end
doublesmoothImage = fix(doublesmoothImage);
smoothImage = uint8(doublesmoothImage);
