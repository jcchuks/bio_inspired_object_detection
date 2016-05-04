function gbImg = gaborFilter()
    a = 512; b = 512;
    delta = 7/3;
    yeta = 1;
    lambda = 7;
    theta.zero = 0;  theta.fortyfive = pi/4; theta.ninety = pi/2;
    theta.onethirtyfive = (3*pi)/4;
    xprime = @(x,y,tetat) ((x * cos(tetat)) + (y* sin(tetat)));
    yprime = @(x,y,tetat) (-(x * sin(tetat)) + (y* cos(tetat)));
    count = 1;
    for th = fieldnames(theta)'
    for i=1:19
        for j=1:19
            h_gb.(th{1})(i,j) = exp(-(xprime(i,j,theta.(th{1}))^2 + (yeta^2 * yprime(i,j,theta.(th{1}))^2))/(2*delta^2) ) * cos(((2*pi*xprime(i,j,theta.(th{1})))/lambda)+pi/2); % + theta.(th{1}));
            
        end
    end
    [gbImg.(th{1}),fx,fy] = freqz2(h_gb.(th{1}),a,b);
    [Fx,Fy] = meshgrid(fx,fy);
    figure(count);
    mesh(Fx,Fy,abs(gbImg.(th{1})));
    count = count +1;
    end
end
