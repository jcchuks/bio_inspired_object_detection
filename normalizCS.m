function img = normalizCS(img,varargin)

if isempty(varargin)
        [x,y] = size(img);
        gloMax = max(max(img));
        [localmin pos] = findpeaks(img(:));
        avg = sum(localmin)/size(localmin,1);
        normVal = (gloMax - avg)^2 ;
        img = img * normVal;
else
        img = img - min(img(:));
  img = img /( max(img(:))-min(img(:)));
end
end