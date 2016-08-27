function obj =  pyramidsGen(image)
     description = '';
    obj.pyramid0 = image;
    obj.pyramid1 = impyramid(image,'reduce');
    obj.pyramid2 = impyramid(obj.pyramid1,'reduce');
    obj.pyramid3 = impyramid(obj.pyramid2,'reduce');
    obj.pyramid4 = impyramid(obj.pyramid3,'reduce');
    obj.pyramid5 = impyramid(obj.pyramid4,'reduce');
    obj.pyramid6 = impyramid(obj.pyramid5,'reduce');
    obj.pyramid7 = impyramid(obj.pyramid6,'reduce');
    obj.pyramid8 = impyramid(obj.pyramid7,'reduce');

    figure(); % title('Pyramid Levels');
    subplot(2,5,1);imshow(image); title('Original')
    subplot(2,5,2);imshow(obj.pyramid1);title('1/2 Original');
    subplot(2,5,3);imshow(obj.pyramid2);title('1/4 Original');
    subplot(2,5,4);imshow(obj.pyramid3);title('1/8 Original');
    subplot(2,5,5);imshow(obj.pyramid4);title('1/16 Original');
    subplot(2,5,6);imshow(obj.pyramid5);title('1/32 Original');
    subplot(2,5,7);imshow(obj.pyramid6);title('1/64 Original');
    subplot(2,5,8);imshow(obj.pyramid7);title('1/128 Original');
    subplot(2,5,9);imshow(obj.pyramid8);title('1/256 Original');
    
%     comment out the for loops to view the image pyramids with their actual sizes
%     for i=fieldnames(obj)'
%         figure()
%         imshow(obj.(i{1}))
%     end 
 
end
