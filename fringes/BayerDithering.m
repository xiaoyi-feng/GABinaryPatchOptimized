function binary_img  = BayerDithering(fringe)

m1 = [[0 2];[3 1]];
u1=ones(2, 2);
m2=[[4*m1 4*m1+2*u1];[4*m1+3*u1 4*m1+u1]];
u2=ones(4, 4);
m3=[[4*m2 4*m2+2*u2];[4*m2+3*u2 4*m2+u2]];
[h,w] = size(fringe);

binary_img = 0;
for i=1:h
    for j=1:w
        if (fringe(i,j) / 4> m3(bitand(i, 7) + 1, bitand(j,7) + 1))
            binary_img(i,j)= 255;
        else
            binary_img(i,j)= 0;
        end
    end
end
% imshow(binary_img);
end