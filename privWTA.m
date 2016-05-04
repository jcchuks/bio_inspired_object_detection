function winFeat = privWTA(img,cC,cO,cI,RGfeatMap,BYfeatMap,IntfeatMap,GFfeatMapze,GFfeatMapff,GFfeatMapnt,GFfeatMapotf)
[maxx row] = max(img,[],1);
[val col] = max(maxx);
[maxx row] = max(img(:,col));

if cC(row,col) > cO(row,col) & cC(row,col) > cI(row,col)
   
   winRG = maxFinder(RGfeatMap,row,col);
   winBY = maxFinder(BYfeatMap,row,col);
   if winRG(row,col) > winBY(row,col)
       winFeat = winRG; 
%      figure()
%      imshow(winFeat);title('Color RG Winning Feature Map');
   else
       winFeat = winBY;  
   end
    values = findpeaks(winFeat(:));
    avg = (min(values) +max(values))/1.68;
%     winFeat = normalizCS(winFeat,'Rectify');
%     (sum(values)/size(values,1)
%     avg = winFeat(row,col)* 0.1;
    cutoff = avg ;
   
    
elseif  cO(row,col) >  cI(row,col)
   winZe = maxFinder(GFfeatMapze,row,col);
   winFf = maxFinder(GFfeatMapff,row,col);
   winNt = maxFinder(GFfeatMapnt,row,col);
   winOtf = maxFinder(GFfeatMapotf,row,col);
   val = max([winZe(row,col),winFf(row,col),winNt(row,col),winOtf(row,col)]);
   defRG = [-inf -inf];
   if val == winZe(row,col)
       winFeat = winZe;
   elseif winFf (row,col)== val
       winFeat =  winFf; 
   elseif winNt(row,col) == val
       winFeat = winNt;
   else winOtf(row,col) == val
       winFeat =  winOtf;
   end
%    cutoff = winFeat(row,col)* 0.1;
%    winFeat (cutoff < winFeat) = 0;
        values = findpeaks(winFeat(:));
    avg = (min(values) +max(values))/1.68; %2;
%     (sum(values)/size(values,1)
    cutoff = avg % winFeat(row,col)* 0.1;

else
    winFeat = maxFinder(IntfeatMap);
    values = findpeaks(winFeat(:));
     avg = (min(values) +max(values))/1.68' %2;
%     (sum(values)/size(values,1)
     cutoff = avg;
    % winFeat(row,col)* 0.1;

end
  figure('Name','Winning Feature Map')
  imshow(winFeat);title('Winning Feature Map');

  winFeat(winFeat > cutoff | winFeat == cutoff) = 1;
  winFeat(winFeat < cutoff) = 0;
  figure('Name','Binary Map')
    imshow(winFeat);title(' Binary Map ');
% bwLabMat= bwlabel(winFeat,4);
% figure()
% imshow(bwLabMat);title('Bwlablel');
% bwLabMat = bwlabel(winFeat,4);
% labelss =max(max((bwlabel(winFeat,4))));
% bwLabMat(labelss < bwLabMat) = 0;
% bwLabMat(labelss == bwLabMat) = 1;
% bwLabMat = im2double(bwLabMat);
% figure()
% imshow(bwLabMat);

end

function maxVal =  maxFinder(someImg,row,col)
 defRG = -inf;
    for rg = fieldnames(someImg)'
        if size(someImg.(rg{1})) < size(someImg.featuremap2);
            someImg.(rg{1}) = imresize(someImg.(rg{1}), size(someImg.featuremap2));
        end
        if someImg.(rg{1})(row,col) > defRG;
            defRG = someImg.(rg{1})(row,col);
            maxVal = someImg.(rg{1});
        end
        
    end
figure('Name','Competing Feature Maps')
imshow(maxVal); title('Competing Feature Map');
end