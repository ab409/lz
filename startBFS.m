function [list, count] = startBFS(row, col, list, count)

for i = -1 : 1
    for j = -1 : 1
        list(count, 1) = row - 1;
        list(count, 2) = col - 1;
        count = count + 1;
        
        list(count, 1) = row - 1;
        list(count, 2) = col;
        count = count + 1;
        
        list(count, 1) = row - 1;
        list(count, 2) = col + 1;
        count = count + 1;
        
        list(count, 1) = row;
        list(count, 2) = col - 1;
        count = count + 1;
        
        list(count, 1) = row;
        list(count, 2) = col + 1;
        count = count + 1;
        
        list(count, 1) = row + 1;
        list(count, 2) = col - 1;
        count = count + 1;
        
        list(count, 1) = row + 1;
        list(count, 2) = col;
        count = count + 1;
        
        list(count, 1) = row + 1;
        list(count, 2) = col + 1;
        count = count + 1;
    end
end

