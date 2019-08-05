function [beta] = pyramid_coding(llc_codes, code1, code2, feaSet)

dSize = size(code1,1) + size(code2,1);
nSmp = size(feaSet.feaArr, 2);

img_width = feaSet.width;
img_height = feaSet.height;
idxBin = zeros(nSmp, 1);

pyramid = [1, 2, 4];

% spatial levels
pLevels = length(pyramid);
% spatial bins on each level
pBins = pyramid.^2;
% total spatial bins
tBins = sum(pBins);

beta = zeros(dSize, tBins);
bId = 0;                   

for iter1 = 1:pLevels,
    
    nBins = pBins(iter1);
    
    wUnit = img_width / pyramid(iter1);
    hUnit = img_height / pyramid(iter1);
    
    % find to which spatial bin each local descriptor belongs
    xBin = ceil(feaSet.x / wUnit);
    yBin = ceil(feaSet.y / hUnit);
    idxBin = (yBin - 1)*pyramid(iter1) + xBin;
    
    for iter2 = 1:nBins,     
        bId = bId + 1;
        sidxBin = find(idxBin == iter2);
        if isempty(sidxBin),
            continue;
        end      
        beta(:, bId) = max(llc_codes(:, sidxBin), [], 2);%beta的大小是1024*21
    end
end

if bId ~= tBins,
    error('Index number error!');
end

beta = beta(:);%拉成列向量后，beta是21504*1，这个21504是如何来的呢？1024*21 = 21504
beta = beta./sqrt(sum(beta.^2));
end