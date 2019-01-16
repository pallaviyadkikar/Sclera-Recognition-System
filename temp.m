for i = 1:255
    for j= 1:255
        if J(i,j)==1
            j1(i,j)= Iidwt(i,j);
        else
            j1(i,j)= 1;
        end
    end
end
figure,imshow(j1);
Y= fftshift(fftshift(j1));
figure,imshow(j1);
fftj1 = fft2(j1,255,255);
magfftj1 = abs(fftj1);
angfftj1 = angle(fftj1);

figure,imshow(uint8(magfftj1));

figure,imshow(uint8(angfftj1));
hold on
[u,v] = pol2cart(angfftj1,8);
x = center(:,2);
y = center(:,1);
q=quiver(x,y,u,v,0.4,'w');
hold off;
imwrite(q,'ori.jpg');
