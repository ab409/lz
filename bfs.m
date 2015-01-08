function image = bfs(image, height, width, startx, starty)

if image(startx, starty) == 0
    image(startx, starty) = 100;
    if startx > 1
        if starty > 1
            image = bfs(image , height, width, startx - 1, starty - 1);
        end
        image = bfs(image , height, width, startx - 1, starty);
        if starty < height
            image = bfs(image , height, width, startx - 1, starty + 1); 
        end
    end
    
    if startx < width
        if starty > 1
            image = bfs(image , height, width, startx + 1, starty - 1);
        end
        image = bfs(image , height, width, startx + 1, starty);
        if starty < height
            image = bfs(image , height, width, startx + 1, starty + 1); 
        end
    end
    
    if starty > 1
        image = bfs(image , height, width, startx, starty - 1); 
    end
    
    if starty < height
        image = bfs(image , height, width, startx, starty + 1); 
    end
end




