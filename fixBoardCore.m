function image = fixBoardCore(image, height, width, startX , startY)

if image(startX, startY) > 100
    image(startX, startY) = 0;
    if startX > 1
        image = fixBoardCore(image, height, width, startX - 1, startY);
    end
    if startX < width
        image = fixBoardCore(image, height, width, startX + 1, startY); 
    end
    if startY > 1
        image = fixBoardCore(image, height, width, startX, startY - 1); 
    end
    if startY < height
        image = fixBoardCore(image, height, width, startX, startY + 1); 
    end
end