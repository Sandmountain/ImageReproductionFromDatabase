%% Image Reproduction
nrOfPixels = 16;
RecreatedImageValues = rgb2lab(imresize(imread('viktor.jpg'),1/nrOfPixels));
%Lab_Image = rgb2lab(orignalImage);

%G�r om databasen till RGB
ImageDateBase_RGB = lab2rgb(ImageDataBase_LAB);

%indexmatrisen f�r vilken bild i datorbasen som h�r till vilket pixelomr�de
idx = ones(size(RecreatedImageValues,1),size(RecreatedImageValues,2));

for a = 1:size(RecreatedImageValues,1)
    for b = 1:size(RecreatedImageValues,2)
        Value_L = RecreatedImageValues(b,a,1);
        Value_A = RecreatedImageValues(b,a,2);
        Value_B = RecreatedImageValues(b,a,3);
        
        difference = mean2(sqrt((Value_L-L_Data(1)).^2 + (Value_A-A_Data(1)).^2 + (Value_B-B_Data(1)).^2));
        for findImage = 1:size(L_Data,1)
            NewDifference = mean2(sqrt((Value_L-L_Data(findImage)).^2 + (Value_A-A_Data(findImage)).^2 + (Value_B-B_Data(findImage)).^2));
            if(NewDifference < difference)          % Hittar minsta differansen
                difference = NewDifference;         % Ekvivalent? med min(pixel,bild)      
                idx(b,a) = findImage;               % Sparar index f�r bilden
            end
        end
    end
end

newImageRangeX = 1:31:(size(idx,1)*32);     %S�tter upp storleken p� slutbilden
newImageRangeY = 1:31:(size(idx,2)*32);

for u = 1:size(idx,1)
    for v = 1:size(idx,2)    
        newImage(newImageRangeX(u):newImageRangeX(u+1),newImageRangeY(v):newImageRangeY(v+1),:) = ImageDateBase_RGB(:,:,:,idx(u,v));   
    end
end

imshow(newImage)