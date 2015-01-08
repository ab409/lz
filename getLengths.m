function lengths = getLengths(image)

[height, width] = size(image);
twoValImg = twoValImage(image);
count = 0;
for i = 1 : height
    for j = 1 : width
        if twoValImg(i, j) == 0
           count = count + 1;
           bfs(twoValImg, height, width, i, j);
        end
    end
end

lengths = count;
