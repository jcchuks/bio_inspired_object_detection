function vab =  centresurround(image2,image3,image4,image5,image6,image7,image8,mapTitle)
    obj.featuremap1 = abs(image2 - imresize(image5,size(image2)));
    obj.featuremap2 = abs(image2 - imresize(image6,size(image2)));
    obj.featuremap3 = abs(image3 - imresize(image6,size(image3)));
    obj.featuremap4 = abs(image3 - imresize(image7,size(image3)));
    obj.featuremap5 = abs(image4 - imresize(image7,size(image4)));
    obj.featuremap6 = abs(image4 - imresize(image8,size(image4)));
    
    count = 1;
    for i = fieldnames(obj)'
        figure(count)
%         imshow(obj.(i{1}));
        count = count + 1;
    end
    
%     only local maxima of activity is considered
   
    for i = fieldnames(obj)'
        img = obj.(i{1});
        vab.(i{1}) = normalizCS(normalizeForConsMap(img),'Rectification');
    end
    
    count = 1;
    firstile = [];
    sectile = [];
    thirdtile = [];;
    for i = fieldnames(vab)'
        if count < 2 || count == 2;
        firstile = [firstile vab.(i{1})];
        elseif count > 2 && count < 5
            sectile = [sectile vab.(i{1})];
        else
             thirdtile = [thirdtile vab.(i{1})];
        end 
        count = count + 1;
    end
%     This resizing has been done for viewing purposes only and adds no
%     computational effect to the model
    sectile = imresize(sectile,size(firstile));
    thirdtile = imresize (thirdtile,size(firstile));
   figure('Name',mapTitle);
  imshow([firstile;sectile;thirdtile]); title(mapTitle);
%      subplot(3,1,2);  imshow(sectile);
%       subplot(3,1,3);  imshow(thirdtile);
        
end

 