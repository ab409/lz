function [perimeter, area] = getDefectPerArea(image, row, col)

[rowCount, colCount] = size(image);
perimeter = 0;
area = 0;
[perimeter, area] = getDefectPerAreaCore(image, rowCount, colCount, row, col, perimeter, area);

