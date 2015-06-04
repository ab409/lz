function varargout = weld_defect_rec(varargin)
% WELD_DEFECT_REC MATLAB code for weld_defect_rec.fig
%      WELD_DEFECT_REC, by itself, creates a new WELD_DEFECT_REC or raises the existing
%      singleton*.
%
%      H = WELD_DEFECT_REC returns the handle to a new WELD_DEFECT_REC or the handle to
%      the existing singleton*.
%
%      WELD_DEFECT_REC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WELD_DEFECT_REC.M with the given input arguments.
%
%      WELD_DEFECT_REC('Property','Value',...) creates a new WELD_DEFECT_REC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before weld_defect_rec_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to weld_defect_rec_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help weld_defect_rec

% Last Modified by GUIDE v2.5 01-Jun-2015 17:17:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @weld_defect_rec_OpeningFcn, ...
                   'gui_OutputFcn',  @weld_defect_rec_OutputFcn, ...
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


% --- Executes just before weld_defect_rec is made visible.
function weld_defect_rec_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to weld_defect_rec (see VARARGIN)

% Choose default command line output for weld_defect_rec
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes weld_defect_rec wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = weld_defect_rec_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in rgb2gray.
function rgb2gray_Callback(hObject, eventdata, handles)
% hObject    handle to rgb2gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rgb2gray


% --- Executes on button press in proProcessBtn.
function proProcessBtn_Callback(hObject, eventdata, handles)
% hObject    handle to proProcessBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
global smoothImage;
csize = str2num(get(handles.coreSize, 'String'));
% coreSize = 15;

% if get(handles.rgb2gray, 'Value')
%    im = rgb2gray(im); 
% end
smoothImage = smooth(im, csize);
figure;
imshow(smoothImage);


function coreSize_Callback(hObject, eventdata, handles)
% hObject    handle to coreSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coreSize as text
%        str2double(get(hObject,'String')) returns contents of coreSize as a double


% --- Executes during object creation, after setting all properties.
function coreSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coreSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in weldLocateBtn.
function weldLocateBtn_Callback(hObject, eventdata, handles)
% hObject    handle to weldLocateBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
global smoothImage;
global fixedImage;
global splineSmoothImage;
global pre;

coreHeight = str2num(get(handles.cHeight, 'String'));
interval = str2num(get(handles.interval, 'String'));

[upBorder, downBorder] = getBorder(smoothImage, coreHeight, interval)
sourceROI = im(upBorder : downBorder, :);
[fixedImage,a,b] = waveDenoise(sourceROI);
histeqImage = fixedImage;
splineSmoothImage = getSplineSmoothImage(histeqImage);
[newImage, fixedImage, fixedUpLine, fixedDownLine] = getExactlyBorderImage(splineSmoothImage);
pre = 1;
figure;
imshow(newImage);



% --- Executes on button press in inputBtn.
function inputBtn_Callback(hObject, eventdata, handles)
% hObject    handle to inputBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
global smoothImage;
global fixedImage;
global splineSmoothImage;
global pre;
pre = 0;
[Filename, Pathname] = uigetfile({ '*.bmp';'*.jpg'},'选择输入文件');
str = [Pathname Filename];
if (Filename ~= 0 )
    im = imread(str);
    mysize = size(im);
    if numel(mysize) > 2
       im = rgb2gray(im); 
    end
    smoothImage = im;
    fixedImage = im;
    splineSmoothImage = im;
    figure;
    imshow(im);
end


% --- Executes on button press in xtxBtn.
function xtxBtn_Callback(hObject, eventdata, handles)
% hObject    handle to xtxBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global splineSmoothImage;
%%
%剪影
subBackImage = subBackground2(splineSmoothImage);
%%
%形态学提取边缘
n = str2num(get(handles.strelTimes, 'String'));
size = str2num(get(handles.strelSize, 'String'));
edgeImage = getEdge3(subBackImage, n);
%%
%阈值分割
segImage = segment2(edgeImage);
%%
%提取缺陷边缘
% finalImage = getOutEdge(segImage);
% showImage(finalImage);

fixBoardImage = fixBoard2(segImage);
dilate = dilateImage3(fixBoardImage, size);
figure;
imshow(dilate);


% --- Executes on button press in iacBtn.
function iacBtn_Callback(hObject, eventdata, handles)
% hObject    handle to iacBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fixedImage;
global pre;
global im;

dt = str2num(get(handles.deltaT, 'String'));
cg = str2num(get(handles.c, 'String'));
t = str2num(get(handles.times, 'String'));
g1 = str2num(get(handles.gamma1, 'String'));
g2 = str2num(get(handles.gamma2, 'String'));
ms = str2num(get(handles.miu, 'String'));
if pre == 1
    iacResult = fastIac2(fixedImage, dt, cg, t, g1, g2, ms);
    showCon(fixedImage, fixedImage, iacResult);
else
    iacResult = iac3(im, dt, cg, t, g1, g2, ms); 
    result4 = iac4(im, dt, cg, t, g1, g2, ms);
    showCon(fixedImage, fixedImage, result4);
end

% --- Executes on button press in BeamletBtn.
function BeamletBtn_Callback(hObject, eventdata, handles)
% hObject    handle to BeamletBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in bpBtn.
function bpBtn_Callback(hObject, eventdata, handles)
% hObject    handle to bpBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bp();

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function cHeight_Callback(hObject, eventdata, handles)
% hObject    handle to cHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cHeight as text
%        str2double(get(hObject,'String')) returns contents of cHeight as a double


% --- Executes during object creation, after setting all properties.
function cHeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function interval_Callback(hObject, eventdata, handles)
% hObject    handle to interval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of interval as text
%        str2double(get(hObject,'String')) returns contents of interval as a double


% --- Executes during object creation, after setting all properties.
function interval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function strelSize_Callback(hObject, eventdata, handles)
% hObject    handle to strelSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of strelSize as text
%        str2double(get(hObject,'String')) returns contents of strelSize as a double


% --- Executes during object creation, after setting all properties.
function strelSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to strelSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function strelTimes_Callback(hObject, eventdata, handles)
% hObject    handle to strelTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of strelTimes as text
%        str2double(get(hObject,'String')) returns contents of strelTimes as a double


% --- Executes during object creation, after setting all properties.
function strelTimes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to strelTimes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function deltaT_Callback(hObject, eventdata, handles)
% hObject    handle to deltaT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of deltaT as text
%        str2double(get(hObject,'String')) returns contents of deltaT as a double


% --- Executes during object creation, after setting all properties.
function deltaT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to deltaT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c_Callback(hObject, eventdata, handles)
% hObject    handle to c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c as text
%        str2double(get(hObject,'String')) returns contents of c as a double


% --- Executes during object creation, after setting all properties.
function c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function times_Callback(hObject, eventdata, handles)
% hObject    handle to times (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of times as text
%        str2double(get(hObject,'String')) returns contents of times as a double


% --- Executes during object creation, after setting all properties.
function times_CreateFcn(hObject, eventdata, handles)
% hObject    handle to times (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gamma1_Callback(hObject, eventdata, handles)
% hObject    handle to gamma1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gamma1 as text
%        str2double(get(hObject,'String')) returns contents of gamma1 as a double


% --- Executes during object creation, after setting all properties.
function gamma1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gamma2_Callback(hObject, eventdata, handles)
% hObject    handle to gamma2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gamma2 as text
%        str2double(get(hObject,'String')) returns contents of gamma2 as a double


% --- Executes during object creation, after setting all properties.
function gamma2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function miu_Callback(hObject, eventdata, handles)
% hObject    handle to miu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of miu as text
%        str2double(get(hObject,'String')) returns contents of miu as a double


% --- Executes during object creation, after setting all properties.
function miu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to miu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
