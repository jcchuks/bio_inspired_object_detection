function binaryMap(salmap)
% [maxx argmaxs] = max(salmap,[],1);
argmaxs = findpeaks(salmap(:));
 weight =sum(argmaxs)/size(argmaxs,1);
   
     
    setneg = salmap < weight;
    salmap(setneg) = 0;
    
    setpos = salmap > weight;
    salmap(setpos) = 1;
    figure()
    imshow(salmap)
end 
