function orientCons = orientationCons(ze,ff,nt,otf)

zesum = sumComponents(ze);
ffsum = sumComponents(ff);
ntsum = sumComponents(nt);
otfsum = sumComponents(otf);

orientsum = zesum + ffsum + ntsum + otfsum;
orientCons = normalizCS(normalizeForConsMap(orientsum),'Rectify');
   
end

function RGSum = sumComponents(RG)
RGfeat4 = RG.featuremap4;
RGSum = zeros(size(RGfeat4));
    for i = fieldnames(RG)'
        if ~strcmp(i,'featuremap4')
            RGSum = RGSum + imresize(RG.(i{1}),size(RGfeat4));
        end
    end
colCons = normalizCS(normalizeForConsMap(RGSum),'Rectify');
end