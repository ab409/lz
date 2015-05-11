function result = getStart(image, row, col, height, width)

count = 1;
list = zeros(2, 1);
[list, count] = startBFS(row, col, list, count);
current = 1;
r1 = row;
r2 = col;
while current < count
    cRow = list(current, 1);
    cCol = list(current, 2);
    if cRow > 0 && cRow < height  && cCol > 0 && cCol < width
        if image(cRow, cCol) > 0
           r1 = cRow;
           r2 = cCol;
           break;
        else
            [list, count] = startBFS(cRow, cCol, list, count);
        end
    end   
    current = current + 1;
end
result(1) = r1;
result(2) = r2;
