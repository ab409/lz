function result = getOutEdge(image)

core = strel('diamond', 3);
dilateImage = imdilate(image, core);
result = uint8(dilateImage - image);