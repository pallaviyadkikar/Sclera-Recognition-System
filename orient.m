function [O,crefd,beta_pri,priptval,pri_m,pri_n,q,direct,center]=orient(img)
%img=imread('ref.jpg');
%img=imresize(img,[100 400]);
[~,~,d]=size(img);
if d==3
    img=rgb2gray(img);
end
imrd=im2double(img);
%figure,imshow(imrd),title('Input Image');
[h,w] = size(imrd);
%direct = zeros(h,w);
W = 16;

%-------------------- NORMALISATION ---------------------------------------
m=mean2(imrd);
stdd=std2(imrd);
varr=stdd^2;
m0=0.39;
var0=0.39;
g=zeros(h,w);
for i=1:h
    for j=1:w
        T= realsqrt((((imrd(i,j)-m)^2)*var0)/varr);
        if imrd(i,j)>m
            g(i,j)=m0+T;
        else 
            g(i,j)=m0-T;
        end
    end
end
%figure,imshow(g),title('Normalised image');

%-----------------------ORIENTATION COMPUTATION----------------------------

imagen=uint8(round(g.*255));
%sum_value = 1;
%bg_certainty = 0;

% defining 16X16 blocks
blockIndex = zeros(ceil(w/W),ceil(h/W));

%times_value = 0;
%minus_value = 0;
center = [];

%The image coordinate system is x axis towards bottom and y axis towards right
filter_gradient = fspecial('sobel');

%to get x gradient
Gx = filter2(filter_gradient,imagen);

%to get y gradient
filter_gradient = transpose(filter_gradient);
Gy = filter2(filter_gradient,imagen);


g1=Gx.*Gy;              
g2=(Gy-Gx).*(Gy+Gx);    %gy²-gx²
g3 = (Gx.*Gx) + (Gy.*Gy);
%figure,imshow(g1),title('Gradient X');
%figure,imshow(g2),title('Gradient Y');
%figure,imshow(g3);

findtheta=[];

O=zeros(h,w);
for i=1:W:h
for j=1:W:w

if j+W-1 < w && i+W-1 < h
times_value = sum(sum(g1(i:i+W-1, j:j+W-1)));       % Vx blocks
minus_value = sum(sum(g2(i:i+W-1, j:j+W-1)));       % Vy blocks
sum_value = sum(sum(g3(i:i+W-1, j:j+W-1)));

if sum_value ~= 0 && times_value ~=0

bg_certainty = (times_value*times_value + minus_value*minus_value)/(W*W*sum_value);

if bg_certainty > 0.05
blockIndex(ceil(i/W),ceil(j/W)) = 1;

%tan_value = atan2(minus_value,2*times_value);
theta1 = pi/2+ atan2(2*times_value,minus_value)/2;      %tan-1 of (Vx/Vy)
findtheta=[findtheta theta1];       % 0 TO 3.1416(pi)
%now the theta is within [0,pi]

theta2=2*theta1;
Oy = sin(theta2);
Ox=cos(theta2);
f = fspecial('gaussian');
cos2theta = filter2(f,Ox); % Smoothed sine and cosine of
sin2theta = filter2(f,Oy);
theta = atan2(sin2theta,cos2theta)/2;
%center = [center;[round(i + (W-1)/2),round(j + (W-1)/2),theta,bg_certainty]];
center = [center;[round(i + (W-1)/2),round(j + (W-1)/2),theta]];
O(i,j)=theta;           % orientation value in angles
end;
end;
end;
end;
end;
direct = zeros(h,w);
% figure;imshow(direct);title('Orientation Field');
hold on
[u,v] = pol2cart(center(:,3),8);
x = center(:,2);
y = center(:,1);
q=quiver(x,y,u,v,0.4,'w');
hold off;
imwrite(q,'ori.jpg');



%--------------------------------------------------------------------------

% z is the orientation in the complex domain.
z=zeros(h,w);
trefc=zeros(h,w);
trefe=zeros(h,w);
tref=zeros(h,w);

for m=1:h
    for n=1:w
          z(m,n)=cos(2*O(m,n))+1i*sin(2*O(m,n));    
          trefc(m,n)=((m+1i*n)/(2*pi*(stdd^2)));
          trefe(m,n)=exp(-((m^2+n^2)/(2*(stdd^2))));
          tref(m,n)=trefc(m,n)*trefe(m,n);
    end
end

ctref=conj(tref);
cref=conv2(z,ctref,'same');

reff= atan2(imag(cref),real(cref));

crefd=zeros(size(reff,1),size(reff,2));
reffptval=zeros(size(reff,1),size(reff,2));
mn=1;
for m=1:size(reff,1)
    for n=1:size(reff,2)
        if reff(m,n)<0
            crefd(m,n)=cref(m,n)*sin(reff(m,n));
% reference pt value (cmplx) just for reference
            reffptval(mn)=crefd(m,n);
% reff pt coordinate values just for reference     
            reffm(mn)=m;
            reffn(mn)=n;
            mn=mn+1;
        else
            crefd(m,n)=0;
        end
    end
end

%primary reff pt and its angle detection 
priptval=max(max(reffptval));    
[pri_m pri_n]=find(crefd==priptval);
beta_pri=atan2(imag(priptval),real(priptval));

%% just to show the REFERENCE POINTS CREFD
[mm nn]=find(crefd>(-1));
module1=zeros(h,w);
module1(mm,nn)=255;
%figure,imshow(module1),title('crefd output');

end

%  CHECK CONVOLUTION AND FIND THE PRIMARY REFF POINT
