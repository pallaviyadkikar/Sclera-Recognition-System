function varargout = Main_Menu(varargin)
% MAIN_MENU MATLAB code for Main_Menu.fig
%      MAIN_MENU, by itself, creates a new MAIN_MENU or raises the existing
%      singleton*.
%
%      H = MAIN_MENU returns the handle to a new MAIN_MENU or the handle to
%      the existing singleton*.
%
%      MAIN_MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_MENU.M with the given input arguments.
%
%      MAIN_MENU('Property','Value',...) creates a new MAIN_MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_Menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_Menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main_Menu

% Last Modified by GUIDE v2.5 09-Mar-2015 20:01:08

% Begin initialization code - DO NOT EDIT
% copyrights@pallaviyadkikar
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_Menu_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_Menu_OutputFcn, ...
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


% --- Executes just before Main_Menu is made visible.
function Main_Menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main_Menu (see VARARGIN)

% Choose default command line output for Main_Menu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main_Menu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main_Menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dec =0;
name = get(handles.edit1,'String');
save name1
cd Database
a=dir;
ext = {'.mat'};
name2 = strcat(name,ext);
sa = size(a,1);
 for i=1:sa
     if not(strcmp(a(i).name,'.')|strcmp(a(i).name,'..')|strcmp(a(i).name,'Thumbs.db'|strcmp(a(i).name,'users')))
         temp = a(i).name;
             if strcmp(temp,name2)
                 dec = 1;
                 break
             end
     end
 end
 cd ..

if dec == 0
    msgbox(['Dear ' name ' your name is not there in database' ]);
    uiwait();
    prompt = 'Do you want to Proceed Press 1';
    chk = inputdlg(prompt);
    chk = cell2mat(chk);
    chk = str2num(chk);
    if chk == 1
        close(gcf);
        Reg();
    else
        close all;
        clear all;
        clc
        return;  
    end
else
    msgbox(['Dear ' name ' your name found in database Let us proceed' ]);
    uiwait();
    prompt = 'Do you want to Proceed Press 1';
    chk = inputdlg(prompt);
    chk = cell2mat(chk);
    chk = str2num(chk);
    if chk == 1
        close(gcf);
        Aut();
    else
        close all;
        clear all;
        clc
        return;  
    end
end
