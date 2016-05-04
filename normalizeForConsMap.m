function img = normalizeForConsMap(imag,varargin)
 
if isempty(varargin)
  iter = 5;
else
  iter = varargin{1};
end

cex = 0.5;
cinh = 1.5;
sigmex = 2/100 * size(imag,2);
sigminh = 25/100 * size(imag,2);
den1 = 2 * pi * (sigmex ^2);
den2 = 2 * pi * (sigminh ^2);
c1 = (cex^2)/den1;
c2 = (cinh^2)/den2;
exp1 = @(x,y)(exp(-1 * ((x^2) + (y^2))/(2*sigmex)));
exp2 = @(x,y)(exp(-1 * ((x^2) + (y^2))/(2*sigminh)));

for x=1:6
    for y = 1:6
        differenceOfGaus(x,y) = (c1*exp1(x,y)) - (c2*exp2(x,y));
    end
end
% Note difference (Capital C) from cinh above. Just lazily using variables in itti & Koch 2001
Cinh = 0.02;

for i=iter
    imag = (imag + conv2(imag,differenceOfGaus,'same')) - Cinh;
    imag(imag < 0) = 0;
end
img = imag;
end

