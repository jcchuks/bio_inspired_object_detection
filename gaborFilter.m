function gbImg = gaborFilter(image,figCount)

    [a,b] = size(image);
    delta = 7/3;
    yeta = 1;
    k = 2;
    lambda = 7;
    theta.zero = 0;
    theta.fortyfive = pi/4;
    theta.ninety = pi/2;
 
    theta.onethirtyfive = (3*pi)/4;
    xprime = @(x,y,tetat) ((x * cos(tetat)) + (y* sin(tetat)));
    yprime = @(x,y,tetat) (-(x * sin(tetat)) + (y* cos(tetat)));
    count = 1;
    for th = fieldnames(theta)'
    for i=1:19
        for j=1:19
            h_gb.(th{1})(i,j) = exp(-(xprime(i,j,theta.(th{1}))^2 + (yeta^2 * yprime(i,j,theta.(th{1}))^2))/(2*delta^2) ) * cos(((2*pi*xprime(i,j,theta.(th{1})))/lambda)+pi/2); % + theta.(th{1}));
            h_gbzero.(th{1})(i,j) = exp(-(xprime(i,j,theta.(th{1}))^2 + (yeta^2 * yprime(i,j,theta.(th{1}))^2))/(2*delta^2) ) * cos(((2*pi*xprime(i,j,theta.(th{1})))/lambda)+0); % + theta.(th{1}));
        end
    end
    [gbImg.(th{1}),fx,fy] = freqz2(h_gb.(th{1}),a,b);
    [gbImgZer.(th{1}),fx,fy] = freqz2(h_gbzero.(th{1}),a,b);
    ImageFourier = fft2(image);
    filteredImg = gbImg.(th{1}) .* ImageFourier;
    filteredImgZer = gbImgZer.(th{1}) .* ImageFourier;
    h_gb.(th{1}) = h_gb.(th{1}) - mean(h_gb.(th{1})(:));
    open1 = h_gb.(th{1})(:);
    h_gb.(th{1}) = h_gb.(th{1})/sqrt(sum(open1.^2));
    
    h_gbzero.(th{1}) = h_gbzero.(th{1}) - mean(h_gbzero.(th{1})(:));
    open2 = h_gbzero.(th{1})(:);
    h_gbzero.(th{1}) = h_gbzero.(th{1})/sqrt(sum(open2.^2));
    ImageIfft.(th{1}) = (conv2(image,h_gb.(th{1}),'same'));
    ImageIfftZer.(th{1}) = (conv2(image,h_gbzero.(th{1}),'same')); 

    ImageComb.(th{1}) =  (ImageIfft.(th{1})) + (ImageIfftZer.(th{1}));
    [Fx,Fy] = meshgrid(fx,fy);
     figure(figCount);
     subplot(2,2,count);
     imshow(ImageComb.(th{1}));
     title(th);
    count = count +1;
    
    gbImg.(th{1}) = ImageComb.(th{1});
    end
    
end
