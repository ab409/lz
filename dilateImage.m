function result = dilateImage(image, size)

se = strel('disk', size);
result = imdilate(image, se);