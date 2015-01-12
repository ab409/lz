function [lengths, twoValImg, startIndexs] = getDefectCount(image)

[height, width] = size(image);
twoValImg = twoValImage(image);
count = 0;

for i = 1 : width
    for j = 1 : height
        if twoValImg(j, i) == 0           
           count = count + 1;
           twoValImg = bfs(twoValImg, height, width, i, j); 
           startIndexs(1, count) = j;
           startIndexs(2, count) = i;
        end
    end
end

lengths = count;
