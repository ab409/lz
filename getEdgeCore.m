function result = getEdgeCore(core, image)

dilateImage = imdilate(image, core);
erodeImage = imerode(image, core);
dilateSubSource = uint8(dilateImage - image);
sourceSubErode = uint8(image - erodeImage);
result = uint8(min2img(dilateSubSource, sourceSubErode));