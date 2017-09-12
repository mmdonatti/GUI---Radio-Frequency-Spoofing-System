function varargout = drone_hacking(varargin)
% DRONE_HACKING MATLAB code for drone_hacking.fig
%      DRONE_HACKING, by itself, creates a new DRONE_HACKING or raises the existing
%      singleton*.
%
%      H = DRONE_HACKING returns the handle to a new DRONE_HACKING or the handle to
%      the existing singleton*.
%
%      DRONE_HACKING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DRONE_HACKING.M with the given input arguments.
%
%      DRONE_HACKING('Property','Value',...) creates a new DRONE_HACKING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before drone_hacking_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to drone_hacking_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help drone_hacking

% Last Modified by GUIDE v2.5 23-Feb-2017 14:55:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @drone_hacking_OpeningFcn, ...
                   'gui_OutputFcn',  @drone_hacking_OutputFcn, ...
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


% --- Executes just before drone_hacking is made visible.
function drone_hacking_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to drone_hacking (see VARARGIN)

% Choose default command line output for drone_hacking
handles.output = hObject;


[unicamp,m1] = imread('logounicamp.jpg','jpg');
[neger,m2] = imread('neger.png','png');
[feec,m3] = imread('feec.gif');

axes(handles.axes1);
imshow(neger,m2);
axis off
axis image

axes(handles.axes2);
imshow(feec,m3);
axis off
axis image

axes(handles.axes3);
imshow(unicamp,m1);
axis off
axis image

handles.increment = 5;

global payload flag tmr starter;

starter = 0;
flag = 0;
payload = ['[';'C';char(0);char(128);char(64);char(128);char(128);char(64);char(64);char(0);char(0);']'];

tmr=timer('TimerFcn',{@TimerCallback,hObject,handles},'Period',0.6,'ExecutionMode','FixedRate');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes drone_hacking wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function TimerCallback(obj,event,hObject,handles)

global flag newdata payload scom;

if (flag == 1) && (newdata == 1)
    t = get(handles.throttle,'value');
    y = get(handles.yaw,'value');
    p = get(handles.pitch,'value');
    r = get(handles.roll,'value');
    payload(3) = char(t);
    payload(4) = char(y);
    payload(6) = char(p);
    payload(7) = char(r);
    
    aux = 0;
    payload(2)= 'C';
    for i=1:8
        aux = aux + payload(i+2);
    end
    aux = bitand(aux,255);
    payload(11) = (255-aux);
    fwrite(scom,payload);
    
    newdata = 0;
    fprintf('\nSent Payload: ');

    fprintf('%X ',payload);
   
       
end
  


% --- Outputs from this function are returned to the command line.
function varargout = drone_hacking_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function throttle_Callback(hObject, eventdata, handles)
% hObject    handle to throttle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function throttle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to throttle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function yaw_Callback(hObject, eventdata, handles)
% hObject    handle to yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function yaw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function pitch_Callback(hObject, eventdata, handles)
% hObject    handle to pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function pitch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function roll_Callback(hObject, eventdata, handles)
% hObject    handle to roll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function roll_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flag scom;

if flag == 1
    fclose(scom);
end
close all;


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flag scom tmr;

if flag == 1
    fclose(scom);
end
%close all;
fclose all;
stop(tmr);
% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
global newdata

switch eventdata.Character
    case 'z'
        %disp('throttle +');
        newdata = 1;
        v = get(handles.throttle,'value');
        set(handles.throttle,'value',min(v+handles.increment,255));
    case 's'
        %disp('throttle -');
        newdata = 1;
        v = get(handles.throttle,'value');
        set(handles.throttle,'value',max(v-handles.increment,0));
    case 'q'
        %disp('yaw left');
        newdata = 1;
        v = get(handles.yaw,'value');
        set(handles.yaw,'value',max(v-handles.increment,0));
    case 'd'
        %disp('yaw right');
        newdata = 1;
        v = get(handles.yaw,'value');
        set(handles.yaw,'value',min(v+handles.increment,255));
    case 30
        newdata = 1;
        v = get(handles.pitch,'value');
        set(handles.pitch,'value',min(v+handles.increment,255));
    case 31
        newdata = 1;
        v = get(handles.pitch,'value');
        set(handles.pitch,'value',max(v-handles.increment,0));
    case 28
        %disp('roll left');
        newdata = 1;
        v = get(handles.roll,'value');
        set(handles.roll,'value',max(v-handles.increment,0));
    case 29
        %disp('roll right');
        newdata = 1;
        v = get(handles.roll,'value');
        set(handles.roll,'value',min(v+handles.increment,255));
        
end

function COM_Callback(hObject, eventdata, handles)
% hObject    handle to COM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of COM as text
%        str2double(get(hObject,'String')) returns contents of COM as a double


% --- Executes during object creation, after setting all properties.
function COM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to COM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in connect.
function connect_Callback(hObject, eventdata, handles)
% hObject    handle to connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global scom flag;

if flag == 0
    port = get(handles.COM,'String');
    scom = serial(port,'BaudRate',115200);
    if scom.Status == 'closed'
        fopen(scom);
    end
    flag = 1;
    set(handles.connect,'String','Disconnect','ForegroundColor',[1 0 0]);
else
   if scom.Status == 'open'
        fclose(scom);
   end
   flag = 0;
   set(handles.connect,'String','Connect','ForegroundColor',[0 0.5 0]);
end

% Update handles structure
guidata(hObject, handles);


function inc_Callback(hObject, eventdata, handles)
% hObject    handle to inc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inc as text
%        str2double(get(hObject,'String')) returns contents of inc as a double


% --- Executes during object creation, after setting all properties.
function inc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.increment = str2double(get(handles.inc,'String'));

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global payload starter flag scom newdata tmr;

if starter == 0
       
    starter = 1;
    start(tmr);
    set(handles.start,'String','Stop','ForegroundColor',[1 0 0]);
    
    t = get(handles.throttle,'value');
    y = get(handles.yaw,'value');
    p = get(handles.pitch,'value');
    r = get(handles.roll,'value');
    payload(3) = char(t);
    payload(4) = char(y);
    payload(6) = char(p);
    payload(7) = char(r);
    
    aux = 0;
    payload(2)= 'C';
    for i=1:8
        aux = aux + payload(i+2);
    end
    aux = bitand(aux,255);
    payload(11) = (255-aux);
    fwrite(scom,payload);
    
    newdata = 0;
    fprintf('\nSent Payload: ');

    fprintf('%X ',payload);
else
    starter = 0;
    set(handles.start,'String','Start','ForegroundColor',[0 0.5 0]);
    stop(tmr);
    if flag == 1
        stop_msg = ['[';'S';char(0);char(0);char(0);char(0);char(0);char(0);char(0);char(0);char(0);']'];
        fwrite(scom,stop_msg);
    end
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global starter flag scom tmr;

starter = 0;
set(handles.start,'String','Start','ForegroundColor',[0 0.5 0]);
stop(tmr);
if flag == 1
    auto_msg = ['[';'A';char(0);char(0);char(0);char(0);char(0);char(0);char(0);char(0);char(0);']'];
    fwrite(scom,auto_msg);
end
