function varargout = MassSpring(varargin)
% MASSSPRING MATLAB code for MassSpring.fig
%      MASSSPRING, by itself, creates a new MASSSPRING or raises the existing
%      singleton*.
%
%      H = MASSSPRING returns the handle to a new MASSSPRING or the handle to
%      the existing singleton*.
%
%      MASSSPRING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MASSSPRING.M with the given input arguments.
%
%      MASSSPRING('Property','Value',...) creates a new MASSSPRING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MassSpring_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MassSpring_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MassSpring

% Last Modified by GUIDE v2.5 24-Sep-2020 20:12:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MassSpring_OpeningFcn, ...
                   'gui_OutputFcn',  @MassSpring_OutputFcn, ...
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


% --- Executes just before MassSpring is made visible.
function MassSpring_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MassSpring (see VARARGIN)

% Choose default command line output for MassSpring
handles.output = hObject;

d = str2double(get(handles.dinput,'String'));
% Update handles structure
handles.dis_end = d;
handles.position_end = 20;
handles.x_end = 0;

hold on
rectangle('Position',[-7 handles.position_end 14 2],'FaceColor',[0 0 0]);
rectangle('Position',[-4 handles.position_end+2 8 13],...
    'FaceColor',[0 0.7 0]);
l_spring2 = linspace(0, 10, 300);
l_spring1 = linspace(0, 20, 300);
plot(sin(l_spring2) - 5, l_spring2, '-r', 'LineWidth', 3);
plot(sin(l_spring2) + 5, l_spring2, '-r', 'LineWidth', 3);
plot(sin(l_spring1), l_spring1, '-b', 'LineWidth', 3);
axis([-8 8 0 40]);
guidata(hObject, handles);

% UIWAIT makes MassSpring wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MassSpring_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in StartButton.
function StartButton_Callback(hObject, eventdata, handles)
% hObject    handle to StartButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Weight = str2double(get(handles.winput,'String'));
distance = str2double(get(handles.dinput,'String'));
K_spring1 = str2double(get(handles.k1input,'String'));
K_spring2 = str2double(get(handles.k2input,'String'));

dis_end = handles.dis_end;
position_end = handles.position_end;
x_end = handles.x_end;

%calculating x(displacement caused by wieght of the load.)

if Weight / K_spring1 < distance
    x = Weight / K_spring1;
else
    x =(Weight+2*K_spring2*distance)/(K_spring1+2*K_spring2);
end

x = x - distance + dis_end;
position_end = position_end - x + x_end;
% plotting the result.
% An if loop for wieght.A for loop for spring_K1. special branch for when
% the resultant hieght is negative.
if handles.position_end >= position_end
    delta_x = (x_end - x)/20;
    for t = 1:20
        cla
        handles.position_end = handles.position_end + delta_x;
        rectangle('Position',[-7, handles.position_end,14,2],...
            'FaceColor',[0 0 0]);
        rectangle('Position',[-4,handles.position_end+2,8,13],...
            'FaceColor',[0 0.7 0]);
        if(handles.position_end <= 10)
            l_spring1 = linspace(0,handles.position_end,300);
            plot(sin(10/(handles.position_end).*l_spring1)-5,l_spring1,...
                '-r','LineWidth',3);
            plot(sin(20/(handles.position_end).*l_spring1),l_spring1,...
                '-b','LineWidth',3);
            plot(sin(10/(handles.position_end).*l_spring1)+5,l_spring1,...
                '-r','LineWidth',3);
        else
            l_spring2 = linspace(0,10,300);
            l_spring1 = linspace(0,handles.position_end,300);
            plot(sin(l_spring2)-5,l_spring2,'-r','LineWidth',3)
            plot(sin(20/(handles.position_end).*l_spring1),l_spring1,...
                '-b','LineWidth',3)
            plot(sin(l_spring2)+5,l_spring2,'-r','LineWidth',3)
        end
        pause(0.06);
        axis([-8,8,0,40]);
    end
elseif position_end > handles.position_end
    delta_x = (x_end-x)/20;
    for t=1:20
        cla
        handles.position_end = handles.position_end + delta_x;
        rectangle('Position',[-7 ,handles.position_end,14,2],...
            'FaceColor',[0 0 0]);
        rectangle('Position',[-4,handles.position_end+2,8,13],...
            'FaceColor',[0 0.7 0]);
        if(handles.position_end <= 10)
            l_spring1 = linspace(0,handles.position_end,300);
            plot(sin(10/(handles.position_end)*l_spring1)- 5, l_spring1,...
                '-r','LineWidth',3);
            plot(sin(20/(handles.position_end)*l_spring1), l_spring1,...
                '-b','LineWidth',3);
            plot(sin(10/(handles.position_end)*l_spring1)+ 5 ,l_spring1,...
                '-r','LineWidth', 3)
        else
            l_spring2 = linspace(0, 10, 300);
            l_spring1 = linspace(0, handles.position_end, 300);
            plot(sin(l_spring2)-5, l_spring2, '-r','LineWidth', 3)
            plot(sin(20/(handles.position_end).*l_spring1), l_spring1,...
                '-b', 'LineWidth', 3)
            plot(sin(l_spring2) + 5, l_spring2, '-r','LineWidth', 3)
        end
        pause(0.06);
        axis([-8, 8, 0, 40]);
    end
end
handles.x_end = x;
guidata(hObject,handles);


function k1input_Callback(hObject, eventdata, handles)
% hObject    handle to k1input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of k1input as text
%        str2double(get(hObject,'String')) returns contents of k1input as a double


% --- Executes during object creation, after setting all properties.
function k1input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k1input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function k2input_Callback(hObject, eventdata, handles)
% hObject    handle to k2input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of k2input as text
%        str2double(get(hObject,'String')) returns contents of k2input as a double


% --- Executes during object creation, after setting all properties.
function k2input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k2input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dinput_Callback(hObject, eventdata, handles)
% hObject    handle to dinput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dinput as text
%        str2double(get(hObject,'String')) returns contents of dinput as a double


% --- Executes during object creation, after setting all properties.
function dinput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dinput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function winput_Callback(hObject, eventdata, handles)
% hObject    handle to winput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of winput as text
%        str2double(get(hObject,'String')) returns contents of winput as a double


% --- Executes during object creation, after setting all properties.
function winput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to winput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
