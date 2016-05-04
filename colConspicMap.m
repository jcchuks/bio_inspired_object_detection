function colCons = colConspicMap(RG,BY)
RGfeat4 = RG.featuremap4;
RGSum = zeros(size(RGfeat4));
    for i = fieldnames(RG)'
        if ~strcmp(i,'featuremap4')
            RGSum = RGSum + imresize(RG.(i{1}),size(RGfeat4));
        end
    end
    
    
% This if statement only works for color conspicuity while the "else" 
% executes for intensity. Perhaps I should have made it neater.
if ~isempty(fieldnames(BY))
    BYfeat4 = BY.featuremap4;
    BYSum = zeros(size(BYfeat4));
    for i = fieldnames(BY)'
        if ~strcmp(i,'featuremap4')
            BYSum = BYSum + imresize(BY.(i{1}),size(BYfeat4));
        end
    end
    RGSumNormalized = normalizCS(normalizeForConsMap(RGSum),'Rectify');
    BYSumNormalized = normalizCS(normalizeForConsMap(BYSum),'Rectify');
    colCons = normalizCS(normalizeForConsMap(RGSumNormalized + BYSumNormalized),'Rectify');
else 
    colCons = normalizCS(normalizeForConsMap(RGSum),'Rectify');
end
   
   
end