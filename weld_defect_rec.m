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

% Last Modified by GUIDE v2.5 22-May-2015 15:39:48

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
coreSize = str2num(get(handles.coreSize, 'String'));

if get(handles.rgb2gray, 'Value')
   im = rgb2gray(im); 
end

smoothImage = smooth(im, coreSize);
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
[upBorder, downBorder] = getUpDownBorder(smoothImage)
sourceROI = im(upBorder : downBorder, :);
[fixedImage,a,b] = waveDenoise(sourceROI);
histeqImage = fixedImage;
splineSmoothImage = getSplineSmoothImage(histeqImage);
[newImage, fixedImage, fixedUpLine, fixedDownLine] = getExactlyBorderImage(splineSmoothImage);
figure;
imshow(newImage);



% --- Executes on button press in inputBtn.
function inputBtn_Callback(hObject, eventdata, handles)
% hObject    handle to inputBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im;
[Filename, Pathname] = uigetfile({ '*.bmp';'*.jpg'},'选择输入文件');
str = [Pathname Filename];
if (Filename ~= 0 )
    im = imread(str);
    figure;
    imshow(im);
end


% --- Executes on button press in xtxBtn.
function xtxBtn_Callback(hObject, eventdata, handles)
% hObject    handle to xtxBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in iacBtn.
function iacBtn_Callback(hObject, eventdata, handles)
% hObject    handle to iacBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in BeamletBtn.
function BeamletBtn_Callback(hObject, eventdata, handles)
% hObject    handle to BeamletBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
