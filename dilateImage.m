function result = dilateImage(image)

se = strel('disk', 1);
result = imdilate(image, se);