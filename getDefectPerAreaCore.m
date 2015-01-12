function [perimeter, area, image] = getDefectPerAreaCore(image, rowCount, colCount, row, col, perimeter, area)
 if image(row, col) == 100
     image(row, col) = 50;
     if col == 1 && row == 1
         if image(row + 1, col) == 255 || image(row, col + 1) == 255 || image(row + 1, col + 1) == 255
             perimeter = perimeter + 1;
         else
             area = area + 1;
         end
     elseif col == 1 && row == rowCount
         if image(row - 1, col) == 255 || image(row - 1, col + 1) == 255 || image(row, col + 1) == 255
             perimeter = perimeter + 1;
         else
             area = area + 1;
         end
     elseif col == 1 && row > 1 && row < rowCount
         if image(row + 1, col) == 255 || image(row, col + 1) == 255 || image(row + 1, col + 1) == 255 || image(row - 1, col) == 255 || image(row - 1, col + 1) == 255
             perimeter = perimeter + 1;
         else
             area = area + 1;
         end
     elseif col == colCount && row == 1
         if image(row, col - 1) == 255 || image(row + 1, col - 1) == 255 || image(row + 1, col) == 255
             perimeter = perimeter + 1;
         else
             area = area + 1;
         end
     elseif col == colCount && row == rowCount
         if image(row, col - 1) == 255 || image(row - 1, col -1 ) == 255 || image(row - 1, col) == 255
             perimeter = perimeter + 1;
         else
             area = area + 1;
         end
     elseif col == colCount && row > 1 && row < rowCount
         if image(row, col - 1) == 255 || image(row + 1, col - 1) == 255 || image(row + 1, col) == 255 || image(row - 1, col -1 ) == 255 || image(row - 1, col) == 255
             perimeter = perimeter + 1;
         else
             area = area + 1;
         end
     elseif col > 1 && col < colCount && row == 1
         if image(row, col - 1) == 255 || image(row, col + 1) == 255 || image(row + 1, col - 1) == 255 || image(row + 1, col) == 255 || image(row + 1, col + 1) == 255
             perimeter = perimeter + 1;
         else
             area = area + 1;
         end
     elseif col > 1 && col < colCount && row == rowCount
         if image(row, col - 1) == 255 || image(row, col + 1) == 255 || image(row - 1, col - 1) == 255 || image(row - 1, col) == 255 || image(row - 1, col + 1) == 255
              perimeter = perimeter + 1;
         else
             area = area + 1;
         end
     else
         if image(row, col - 1) == 255 || image(row, col + 1) == 255 || image(row + 1, col - 1) == 255 || image(row + 1, col) == 255 || image(row + 1, col + 1) == 255 || image(row - 1, col - 1) == 255 || image(row - 1, col) == 255 || image(row - 1, col + 1) == 255
              perimeter = perimeter + 1;
         else
             area = area + 1;
         end
     end

     if col > 1
        if row > 1
            [perimeter, area, image] = getDefectPerAreaCore(image, rowCount, colCount, row - 1, col - 1, perimeter, area);
        end
        [perimeter, area, image] = getDefectPerAreaCore(image, rowCount, colCount, row, col - 1, perimeter, area);
        if row < rowCount
            [perimeter, area, image] = getDefectPerAreaCore(image, rowCount, colCount, row + 1, col - 1, perimeter, area);
        end
     end

    if row > 1
        [perimeter, area, image] = getDefectPerAreaCore(image, rowCount, colCount, row - 1, col, perimeter, area);
    end

    if row < rowCount
        [perimeter, area, image] = getDefectPerAreaCore(image, rowCount, colCount, row + 1, col, perimeter, area);
    end

    if col < colCount
        if row > 1
            [perimeter, area, image] = getDefectPerAreaCore(image, rowCount, colCount, row - 1, col + 1, perimeter, area);
        end
        [perimeter, area, image] = getDefectPerAreaCore(image, rowCount, colCount, row, col + 1, perimeter, area);
        if row < rowCount
            [perimeter, area, image] = getDefectPerAreaCore(image, rowCount, colCount, row + 1, col + 1, perimeter, area);
        end
    end  
 end