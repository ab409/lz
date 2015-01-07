function result = hatSubBack(image)

se = strel('disk', 4);
result=imsubtract(imadd(image,imtophat(image,se)),imbothat(image,se));