function [RG BY] = generateMaps (R,G,B)
    luminThresh = 1/10;
    maxx =  max(max(R,G),B);
    RG = (R - G) ./maxx; 
    BY = (B - min(R, G)) ./ maxx;
    setThresh = maxx < luminThresh;
    RG(setThresh) = 0;
    BY(setThresh) = 0;
   
end 
