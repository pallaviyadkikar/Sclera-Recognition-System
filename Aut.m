function varargout = Aut(varargin)
% AUT MATLAB code for Aut.fig
%      AUT, by itself, creates a new AUT or raises the existing
%      singleton*.
%
%      H = AUT returns the handle to a new AUT or the handle to
%      the existing singleton*.
%
%      AUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUT.M with the given input arguments.
%
%      AUT('Property','Value',...) creates a new AUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Aut_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Aut_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Aut

% Last Modified by GUIDE v2.5 19-Mar-2016 00:11:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Aut_OpeningFcn, ...
                   'gui_OutputFcn',  @Aut_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Aut is made visible.
function Aut_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Aut (see VARARGIN)

% Choose default command line output for Aut
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes Aut wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Aut_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global testimg
%% Inputs
% load name1
% name = cellstr(name)
% name = cell2mat(name);
% set(handles.text2,'string',cellstr(name))
[x y] = uigetfile('*.jpg','Select an Image'); 
testimg = imread([y x]);
testimg=imresize(testimg,[255 255]);
axes(handles.axes1);
imshow(testimg); title('Input Eye Image','FontSize',15,'Color','r'); 
axis off


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global testimg
global I 

if size(testimg,3) == 3
      I = rgb2gray(testimg);
end
axes(handles.axes1);
imshow(I);title('Pre Processed Image','FontSize',15,'Color','r'); 
impixelinfo;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global testimg
global I 
global R
global G
global B 

R = testimg(:,:,1);
msgbox('Red Plane Image ');
uiwait();
axes(handles.axes1);imshow(R);title('Red Plane Image','FontSize',15,'Color','r'); 
G = testimg(:,:,2); 
msgbox('Greeen Plane Image ');
uiwait();
axes(handles.axes1);
imshow(G);title('Green Plane Image','FontSize',15,'Color','r'); 
B = testimg(:,:,3);
msgbox('Blue Plane Image ');
uiwait();
axes(handles.axes1);imshow(B);title('Blue Plane Image','FontSize',15,'Color','r'); 


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global G
global enhances_contrast
global enhances_intensity
global M
global N

[M,N]=size(G);
  s=zeros(M,N);
  for i=1:M
      for j=1:N
          if G(i,j)<150;
             G(i,j)=0;
             
          end
      end
  end
  
axes(handles.axes1);imshow(G),title('Segmented Sclera','FontSize',15,'Color','r'); 
enhances_contrast=adapthisteq(G);
enhances_intensity=imadjust(enhances_contrast);
binary_conv = imcomplement (enhances_intensity);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global G
global gabout

Sx = 5; % Variances along x
Sy =5; % Variances along y
U = 5; % Centre frequencies  along x
V = 5; % Centre frequencies  along y
if isa(G,'double')~=1 
    segsclera = double(G);%convert to double type
end
for x = -fix(Sx):fix(Sx) %along x
    for y = -fix(Sy):fix(Sy) %along y
        G1(fix(Sx)+x+1,fix(Sy)+y+1) = (1/(2*pi*Sx*Sy))*exp(-.5*((x/Sx)^2+(y/Sy)^2)+2*pi*1i*(U*x+V*y));%filter eqn
    end
end
Imgabout = conv2(segsclera,double(imag(G1)),'same');%imaginary part
Regabout = conv2(segsclera,double(real(G1)),'same');%real part
gabout= sqrt(Imgabout.*Imgabout + Regabout.*Regabout);%final gabor filter,real + imaginary
axes(handles.axes1);imshow(gabout,[]);title('Gabor Features','FontSize',15,'Color','r');


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global G
global J
global M
global N
global rt2
G=imcrop(G,[18 87 103 101]);
G=imresize(G,[255 255]);

sa = 0.1;
rt = mim(G,sa);

[tt1,e1,cmtx] = myThreshold(rt);

ms = 2;    
mk = msk(G,ms);

rt2 = 255*ones(M,N);
for i=1:M
    for j=1:N
        if rt(i,j)>=tt1 & mk(i,j)==255
            rt2(i,j)=0;
        end
    end
end
J = im2bw(rt2); 

J= ~J;
[Label,Num] = bwlabel(J);
Lmtx = zeros(Num+1,1);
for i=1:M
    for j=1:N
        Lmtx(double(Label(i,j))+1) = Lmtx(double(Label(i,j))+1) + 1;
    end
end
sLmtx = sort(Lmtx);
cp = 0.1;
for i=1:M
    for j=1:N
        if (Lmtx(double(Label(i,j)+1)) > cp) & (Lmtx(double(Label(i,j)+1)) ~= sLmtx(Num+1,1))
            J(i,j) = 0;
        else
            J(i,j) = 1;
        end
    end
end
for i=1:M
    for j=1:N
        if mk(i,j)==0
            J(i,j)=1;
        end
    end
end
axes(handles.axes1); imshow(J,[]);title('Segmented Vein Pattern','FontSize',15,'Color','r');
imwrite(J,'veinseye.tif');
jk=imread('veinseye.tif');
segv=J;


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global J
global points
points = detectSURFFeatures(J);
spoints = mat2cell(points.selectStrongest(50)); 
handles.axes1;imshow(J);
title('SURF Points ','FontSize',15,'Color','r');
hold on;
plot(points.selectStrongest(25));
hold off;


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global J
global G
global templ
global Y E
[cag, chg, cvg, cdg] = dwt2(G,'db1');
[caj, chj, cvj, cdj] = dwt2(J,'db1');
chc =  xor(chg,chj);
cvc =  xor(cvg,cvj);
cdc =  xor(cdg,cdj);
templ = idwt2(caj,chc,cvc,cdc,'db1');
glcm = graycomatrix(templ,'Offset',[2 0;0 2]);
regprop = regionprops(J,'Area','EulerNumber','Perimeter')
stats = graycoprops(glcm,'Contrast','Energy','Correlation');
egy = mean(stats.Energy);
cont = mean(stats.Contrast);
Corre = mean(stats.Correlation);
area = regprop.Area;
eunum = regprop.EulerNumber;
perim = regprop.Perimeter;
data = [egy cont Corre area eunum perim];
templ = imresize(templ,[16 16]);
save('templ.mat','templ');
save('data.mat','data')
handles.axes1
imshow(templ);title('Template','FontSize',15,'Color','r');
load net_fffbp
a = [data(1:2)];
x = [data(3) data(3)];
[~,Y,E ] = adapt(net_fffbp,a,x);
Y = round(Y)
E = round(E)



% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Y templ
% load templ
cd Database
a=dir;
count=0;
dec=0;
for i=1:size(a,1)
     if not(strcmp(a(i).name,'.')|strcmp(a(i).name,'..')|strcmp(a(i).name,'Thumbs.db'))
         count=count+1;
         temp=a(i).name;
         sav_data = load(temp);
         sav_data = struct2cell(sav_data);
         sav_data = cell2mat(sav_data);     
         di = pdist2(templ,sav_data,'cosine');
         di = max(max(di));
         if di > 0.09
             Y = max(Y);
             if Y == 1
                 msgbox('Image Is Registered');
                 uiwait();
             else
                 msgbox('Image Is Not Registered');
                 uiwait();
             end
             name=temp(1:end-4);
             msgbox([name '--Authenticated Person' ]); 
             uiwait();
                dec=1;
             break
         end
     end
 end
 cd ..
 if dec~=1
    errordlg('Person Authentication Failed','Database Error');
    uiwait();
 end
    


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);
delete('data.mat','name1.mat','templ.mat');
Main_Menu();
