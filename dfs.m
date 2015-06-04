function [gray, count, image] = dfs(image, height, width, col, row, count, gray)

if image(row, col) > 0
    count = count + 1;
    gray = gray + image(row, col);
    image(row, col) = -10;    
    if col > 1
        if row > 1
            [gray, count, image] = dfs(image , height, width, col - 1, row - 1, count, gray);            
        end
        [gray, count, image] = dfs(image , height, width, col - 1, row, count, gray); 
        if row < height
            [gray, count, image] = dfs(image , height, width, col - 1, row+ 1, count, gray);  
        end
    end
    
    if col < width
        if row > 1
            [gray, count, image] = dfs(image , height, width,  col+ 1, row - 1, count, gray);  
        end
        [gray, count, image] = dfs(image , height, width, col + 1, row, count, gray);  
        if row < height
            [gray, count, image] = dfs(image , height, width, col + 1, row + 1, count, gray);  
        end
    end
    
    if row > 1
        [gray, count, image] = dfs(image , height, width, col, row - 1, count, gray);  
    end
    
    if row < height
        [gray, count, image] = dfs(image , height, width, col, row + 1, count, gray);  
    end
end