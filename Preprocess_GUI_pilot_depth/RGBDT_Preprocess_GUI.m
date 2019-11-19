function varargout = RGBDT_Preprocess_GUI(varargin)
% RGBDT_Preprocess_GUI MATLAB code for RGBDT_Preprocess_GUI.fig
%      RGBDT_Preprocess_GUI, by itself, creates a new RGBDT_Preprocess_GUI or raises the existing
%      singleton*.
%
%      H = RGBDT_Preprocess_GUI returns the handle to a new RGBDT_Preprocess_GUI or the handle to
%      the existing singleton*.
%
%      RGBDT_Preprocess_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RGBDT_Preprocess_GUI.M with the given input arguments.
%
%      RGBDT_Preprocess_GUI('Property','Value',...) creates a new RGBDT_Preprocess_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RGBDT_Preprocess_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RGBDT_Preprocess_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RGBDT_Preprocess_GUI

% Last Modified by GUIDE v2.5 24-Oct-2017 21:14:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @RGBDT_Preprocess_GUI_OpeningFcn, ...
    'gui_OutputFcn',  @RGBDT_Preprocess_GUI_OutputFcn, ...
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

% --- Executes just before RGBDT_Preprocess_GUI is made visible.
function RGBDT_Preprocess_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RGBDT_Preprocess_GUI (see VARARGIN)

% Choose default command line output for RGBDT_Preprocess_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using RGBDT_Preprocess_GUI.
if strcmp(get(hObject,'Visible'),'off')
    plot(rand(5));
end

% UIWAIT makes RGBDT_Preprocess_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RGBDT_Preprocess_GUI_OutputFcn(hObject, eventdata, handles)
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
axes(handles.axes3);
cla;

popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
    case 1
        plot(rand(5));
    case 2
        plot(sin(1:0.01:25.99));
    case 3
        bar(1:.5:10);
    case 4
        plot(membrane);
    case 5
        surf(peaks);
end


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
    ['Close ' get(handles.figure1,'Name') '...'],...
    'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(isempty(get(handles.edit1, 'String')))
    handles.root_folder = uigetdir('Select the data path');
else
    handles.root_folder = get(handles.edit1, 'String');
end
handles.rgb_folder = [handles.root_folder '\kinect_rgb\'];
handles.depth_folder = [handles.root_folder '\kinect_depth\'];
handles.axis_thermal_folder = [handles.root_folder '\axis_thermal\'];
handles.axis_rgb_folder = [handles.root_folder '\axis_rgb\'];
handles.rest_folder = [handles.root_folder '\'];
%[thermal_file,thermal_folder] = uigetfile('*.*','Select the thermal video file');

% Update handles structure
guidata(hObject, handles);
display('Done selection');



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%[FileName,PathName] = uigetfile('*.*','Select the pain data file to load');

% Load frames
handles.rgb_files  = dir([handles.rgb_folder '*.jpg']);
handles.depth_files  = dir([handles.depth_folder '*.png']);

handles.file_index = 1;
handles.rgb_index = [];

for file_index = 1:(length(handles.rgb_files)-1)
    display(file_index);
    
    rgb_frame = imread([handles.rgb_folder handles.rgb_files(file_index).name]);
    depth_frame = imread([handles.depth_folder handles.depth_files(file_index).name]);
    
    %saving data in array to backtrack
    handles.rgb_index = cat(1, handles.rgb_index, file_index);
    
    %showing images in the handle
    axes(handles.axes1); cla; imshow(rgb_frame); hold on;
    %     imshow(flipdim(thermal_frame, 2), 'Parent', handles.axes4);
    imshow(histeq(depth_frame), 'Parent', handles.axes4); %apply histequalization
    
end

% Update handles structure
guidata(hObject, handles);

display('Complete finding');




% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% open thermal video file for frame extraction
axis_rgb_vid = VideoReader([handles.axis_rgb_folder '\RGB_1_2017-04-22_18-57-48_mpeg4.mp4']);
axis_rgb_Fs = axis_rgb_vid.FrameRate;
axis_thermal_vid = VideoReader([handles.axis_thermal_folder '\Thermal_2_2017-04-22_18-57-49_mpeg4.mp4']);
axis_thermal_Fs = axis_thermal_vid.FrameRate;


handles.file_index = 1;
axis_thermal_file_index = 1;

handles.rgb_index = [];
handles.thermal_index = [];


for axis_rgb_file_index = 1:axis_rgb_vid.NumberOfFrames-5
    display(axis_rgb_file_index);
    
    axis_rgb_frame = read(axis_rgb_vid, round(axis_rgb_file_index));
    
    axis_thermal_file_index = axis_thermal_file_index+(axis_thermal_Fs/axis_rgb_Fs);
    axis_thermal_frame = read(axis_thermal_vid, round(axis_thermal_file_index));
    
    %saving data in array to backtrack
    handles.rgb_index = cat(1, handles.rgb_index, axis_rgb_file_index);
    handles.thermal_index = cat(1, handles.thermal_index, round(axis_thermal_file_index));
    
    %showing images in the handle
    imshow(axis_rgb_frame, 'Parent', handles.axes1);
    imshow(axis_thermal_frame, 'Parent', handles.axes4);
    %     axes(handles.axes1); cla; imshow(axis_rgb_frame); hold on;
    %     imshow(histeq(axis_thermal_frame), 'Parent', handles.axes5); %apply histequalization
    
end

% Update handles structure
guidata(hObject, handles);

display('Complete finding');





% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%setting datapath
path = 'Data\sub1_day_exp_data\session001';

% Load frames for kinect
handles.kinect_rgb_files  = dir([handles.rgb_folder '*.jpg']);
handles.kinect_depth_files  = dir([handles.depth_folder '*.png']);
handles.axis_rgb_video  = dir([handles.axis_rgb_folder '*.mp4']);
handles.axis_thermal_video  = dir([handles.axis_thermal_folder '*.mp4']);

% open axis rgb and thermal video files for frame extraction
%axis_rgb_vid = VideoReader([handles.axis_rgb_folder '\1_2017-04-21_16-39-20_mpeg4.mp4']);
axis_rgb_vid = VideoReader([handles.axis_rgb_video.folder '\' handles.axis_rgb_video.name]);
axis_rgb_Fs = axis_rgb_vid.FrameRate; %ispy64 video edited to 30 fps by 'any video converter'
%axis_thermal_vid = VideoReader([handles.axis_thermal_folder '\2_2017-04-21_16-39-20_mpeg4.mp4']);
axis_thermal_vid = VideoReader([handles.axis_thermal_video.folder '\' handles.axis_thermal_video.name]);
axis_thermal_Fs = axis_thermal_vid.FrameRate; %ispy64 video edited to 30 fps by 'any video converter'


handles.file_index = 1;
kinect_file_index_adjust = 0; %added to depth file reading index to handle kinect rgb and depth file missing
axis_thermal_file_index = 853; %to match with kinect starting time
axis_rgb_file_index = 853; %to match with kinect starting time

%for saving the file reading sequence with synchronization
graph_roi = [];
handles.kinect_rgb_index = [];
handles.kinect_depth_index = [];
handles.axis_rgb_index = [];
handles.axis_thermal_index = [];

for file_index = 110:(length(handles.kinect_rgb_files)-1)
    
    %calculating rgb and thermal frame index for axis videos from kinect frame rate
    next_frame_time = str2double(handles.kinect_rgb_files(file_index+1).name(11:12)) + ...
        str2double(handles.kinect_rgb_files(file_index+1).name(14:17))/10000.0;
    current_frame_time = str2double(handles.kinect_rgb_files(file_index).name(11:12)) + ...
        str2double(handles.kinect_rgb_files(file_index).name(14:17))/10000.0;
    if((next_frame_time-current_frame_time)>0)
        kinect_rgb_Fs = 1.0/(next_frame_time-current_frame_time);
    else
        kinect_rgb_Fs = 1.0/((60-current_frame_time)+next_frame_time);
    end
    axis_rgb_file_index = axis_rgb_file_index+(axis_rgb_Fs/kinect_rgb_Fs);
    axis_thermal_file_index = axis_thermal_file_index+(axis_thermal_Fs/kinect_rgb_Fs);
    
    %handling kinect rgb or depth frame missing by tracing in the future depth frames or skipping rgb frame
    if ~strcmp(handles.kinect_rgb_files(file_index).name(5:17), handles.kinect_depth_files(file_index+kinect_file_index_adjust).name(3:15))
        disp('before');
        disp(handles.kinect_rgb_files(file_index).name(5:17));
        disp(handles.kinect_depth_files(file_index+kinect_file_index_adjust).name(3:15));
        kinect_file_index_updated = 0; %to be used to handle kinect rgb and depth file missing
        %tracing in the future depth frames for the missing depth frame
        for i = 1:20
            if strcmp(handles.kinect_rgb_files(file_index).name(5:17), handles.kinect_depth_files(file_index+kinect_file_index_adjust+i).name(3:15))
                %found the corresponding depth frame, so proceed..
                kinect_file_index_adjust = kinect_file_index_adjust+i;
                kinect_file_index_updated = 1; %indicating that corresponding depth frame found
                break;
            end
        end
        disp('after');
        disp(handles.kinect_rgb_files(file_index).name(5:17));
        disp(handles.kinect_depth_files(file_index+kinect_file_index_adjust).name(3:15));
        if kinect_file_index_updated == 0
            %corresponding depth frame not found, so skipping the iteration for rgb, but keepiong the depth frame for next
            kinect_file_index_adjust = kinect_file_index_adjust-1;
            continue;
        end
    end
    
    %Avoiding file index out of limit error by stoping before exceeding
    if ((axis_thermal_file_index>=axis_thermal_vid.NumberOfFrame)||...
            (axis_rgb_file_index>=axis_rgb_vid.NumberOfFrame)||...
            ((file_index+kinect_file_index_adjust)>=length(handles.kinect_depth_files)))
        break;
    end
    
    
    %reading kinect rgb frame
    kinect_rgb_frame = imread([handles.rgb_folder handles.kinect_rgb_files(file_index).name]);
    
    %reading kinect depth frame
    kinect_depth_frame = imread([handles.depth_folder handles.kinect_depth_files(file_index+kinect_file_index_adjust).name]);
    
    %reading axis rgb frame
    axis_rgb_frame = flip(read(axis_rgb_vid, round(axis_rgb_file_index)), 2);
    
    %reading axis thermal frame
    axis_thermal_frame = flip(read(axis_thermal_vid, round(axis_thermal_file_index)), 2);
    
    
    %saving data in array to backtrack
    handles.kinect_rgb_index = cat(1, handles.kinect_rgb_index, file_index);
    handles.kinect_depth_index = cat(1, handles.kinect_depth_index, file_index);
    handles.axis_rgb_index = cat(1, handles.axis_rgb_index, axis_rgb_file_index);
    handles.thermal_index = cat(1, handles.axis_thermal_index, round(axis_thermal_file_index));
    
    %showing images in the handle
    imshow(kinect_rgb_frame, 'Parent', handles.axes1);
    imshow(histeq(kinect_depth_frame), 'Parent', handles.axes2); %apply histequalization
    imshow(axis_rgb_frame, 'Parent', handles.axes3);
    imshow(axis_thermal_frame, 'Parent', handles.axes4);
    pause(0.0001); % Pause a fraction of a second to slow down the video.
    
    %     axes(handles.axes1); cla; imshow(axis_rgb_frame); hold on;
    %     imshow(histeq(axis_thermal_frame), 'Parent', handles.axes5); %apply histequalization
    %     imshow(flipdim(thermal_frame, 2), 'Parent', handles.axes4);
    
    display([file_index axis_rgb_file_index axis_thermal_file_index]);
    
    %     %displaying to check time synchronization for kinect and axis modalites
    %     if (rem(file_index, 1000)==0)
    %     figure; imshow(axis_rgb_frame);
    %     figure; imshow(axis_thermal_frame);
    %     disp(handles.kinect_rgb_files(file_index).name(5:17));
    %     disp(handles.kinect_depth_files(file_index+kinect_file_index_adjust).name(3:15));
    %     end
    
    
    % assuing indicator roi is at rectangle('position', [1568, 423, 15, 15]);
    indicator_roi = kinect_rgb_frame(627:627+15, 1355:1355+15, :);
    imshow(indicator_roi, 'Parent', handles.axes5);
    
    %finding pain indicator on/off
    mean_roi = mean(indicator_roi(:))
    graph_roi = cat(1, graph_roi, mean_roi);
    %mean_channel = squeeze(mean(mean(indicator_roi(:, :, 1:3))));
    %     roi_threshold = 130;
    %     max_roi_threshold = roi_threshold+40;
    %     frame_skip = 50; %normally 50
    %     if((mean_roi > roi_threshold)&&(mean_roi < max_roi_threshold))
    %
    %         %display(i);
    %         if(handles.file_index<file_index)
    %             for i = 50:-1:0
    %
    %                 if (file_index+i)>=length(handles.rgb_files) continue; end
    %                 %finding pain indicator on/off
    %                 rgb_frame = imread([handles.rgb_folder handles.rgb_files(file_index+i).name]);
    %                 indicator_roi = rgb_frame(427:427+15, 1572:1572+15, :);
    %                 mean_roi = mean(indicator_roi(:));
    %                 %saving RGB start and ending indexes for pain points
    %                 if(mean_roi > roi_threshold)
    %                     handles.rgb_start_index = cat(1, handles.rgb_start_index, (file_index-3));
    %                     handles.rgb_end_index = cat(1, handles.rgb_end_index, (file_index+i+3));
    %                     break;
    %                 end
    %             end
    %             pain_index = pain_index+1
    %             handles.file_index = file_index+frame_skip;
    %             display(file_index);
    %         end
    %     end
    %     if file_index > (length(handles.rgb_files)-5)
    %         figure; plot(graph_roi);
    %         hold on;
    %         plot(handles.rgb_start_index(:, 1), graph_roi(1, :), 'Marker', '+', 'Color', 'r');
    %         hold off;
    %         break;
    %     end
    %
    
    
end

% Update handles structure
guidata(hObject, handles);

display('Complete video exploration');


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%setting datapath
path = 'Data\sub1_day_exp_data\session001';

% Load frames for kinect
handles.kinect_rgb_files  = dir([handles.rgb_folder '*.jpg']);
handles.kinect_depth_files  = dir([handles.depth_folder '*.png']);
handles.axis_rgb_video  = dir([handles.axis_rgb_folder '*.mp4']);
handles.axis_thermal_video  = dir([handles.axis_thermal_folder '*.mp4']);

% open axis rgb and thermal video files for frame extraction
%axis_rgb_vid = VideoReader([handles.axis_rgb_folder '\1_2017-04-21_16-39-20_mpeg4.mp4']);
axis_rgb_vid = VideoReader([handles.axis_rgb_video.folder '\' handles.axis_rgb_video.name]);
axis_rgb_Fs = axis_rgb_vid.FrameRate; %ispy64 video edited to 30 fps by 'any video converter'
%axis_thermal_vid = VideoReader([handles.axis_thermal_folder '\2_2017-04-21_16-39-20_mpeg4.mp4']);
axis_thermal_vid = VideoReader([handles.axis_thermal_video.folder '\' handles.axis_thermal_video.name]);
axis_thermal_Fs = axis_thermal_vid.FrameRate; %ispy64 video edited to 30 fps by 'any video converter'


handles.file_index = 1;
kinect_file_index_adjust = 0; %added to depth file reading index to handle kinect rgb and depth file missing
axis_thermal_file_index = 1; %to match with kinect starting time
axis_rgb_file_index = 41; %to match with kinect starting time

%for saving the file reading sequence with synchronization
handles.kinect_rgb_index = [];
handles.kinect_depth_index = [];
handles.axis_rgb_index = [];
handles.axis_thermal_index = [];

%variables for movement analysis of patient
axis_rgb_frame_prev = []; %keeping the previous frame
axis_thermal_frame_prev = [];
kinect_rgb_frame_prev = [];
kinect_depth_frame_prev = [];

axis_rgb_movement = []; %keeping average movement of each frame over video
axis_thermal_movement = [];
kinect_rgb_movement = [];
kinect_depth_movement = [];

for file_index = 1:(length(handles.kinect_rgb_files)-1)
    
    %calculating rgb and thermal frame index for axis videos from kinect frame rate
    next_frame_time = str2double(handles.kinect_rgb_files(file_index+1).name(11:12)) + ...
        str2double(handles.kinect_rgb_files(file_index+1).name(14:17))/10000.0;
    current_frame_time = str2double(handles.kinect_rgb_files(file_index).name(11:12)) + ...
        str2double(handles.kinect_rgb_files(file_index).name(14:17))/10000.0;
    if((next_frame_time-current_frame_time)>0)
        kinect_rgb_Fs = 1.0/(next_frame_time-current_frame_time);
    else
        kinect_rgb_Fs = 1.0/((60-current_frame_time)+next_frame_time);
    end
    axis_rgb_file_index = axis_rgb_file_index+(axis_rgb_Fs/kinect_rgb_Fs);
    axis_thermal_file_index = axis_thermal_file_index+(axis_thermal_Fs/kinect_rgb_Fs);
    
    %handling kinect rgb or depth frame missing by tracing in the future depth frames or skipping rgb frame
    if ~strcmp(handles.kinect_rgb_files(file_index).name(5:17), handles.kinect_depth_files(file_index+kinect_file_index_adjust).name(3:15))
        disp('before');
        disp(handles.kinect_rgb_files(file_index).name(5:17));
        disp(handles.kinect_depth_files(file_index+kinect_file_index_adjust).name(3:15));
        kinect_file_index_updated = 0; %to be used to handle kinect rgb and depth file missing
        %tracing in the future depth frames for the missing depth frame
        for i = 1:20
            if strcmp(handles.kinect_rgb_files(file_index).name(5:17), handles.kinect_depth_files(file_index+kinect_file_index_adjust+i).name(3:15))
                %found the corresponding depth frame, so proceed..
                kinect_file_index_adjust = kinect_file_index_adjust+i;
                kinect_file_index_updated = 1; %indicating that corresponding depth frame found
                break;
            end
        end
        disp('after');
        disp(handles.kinect_rgb_files(file_index).name(5:17));
        disp(handles.kinect_depth_files(file_index+kinect_file_index_adjust).name(3:15));
        if kinect_file_index_updated == 0
            %corresponding depth frame not found, so skipping the iteration for rgb, but keepiong the depth frame for next
            kinect_file_index_adjust = kinect_file_index_adjust-1;
            continue;
        end
    end
    
    %Avoiding file index out of limit error by stoping before exceeding
    if ((axis_thermal_file_index>=axis_thermal_vid.NumberOfFrame)||...
            (axis_rgb_file_index>=axis_rgb_vid.NumberOfFrame)||...
            ((file_index+kinect_file_index_adjust)>=length(handles.kinect_depth_files)))
        break;
    end
    
    
    %reading kinect rgb frame
    kinect_rgb_frame = imread([handles.rgb_folder handles.kinect_rgb_files(file_index).name]);
    
    %reading kinect depth frame
    kinect_depth_frame = imread([handles.depth_folder handles.kinect_depth_files(file_index+kinect_file_index_adjust).name]);
    
    %reading axis rgb frame
    axis_rgb_frame = flip(read(axis_rgb_vid, round(axis_rgb_file_index)), 2);
    
    %reading axis thermal frame
    axis_thermal_frame = flip(read(axis_thermal_vid, round(axis_thermal_file_index)), 2);
    
    
    %saving data in array to backtrack
    handles.kinect_rgb_index = cat(1, handles.kinect_rgb_index, file_index);
    handles.kinect_depth_index = cat(1, handles.kinect_depth_index, file_index);
    handles.axis_rgb_index = cat(1, handles.axis_rgb_index, axis_rgb_file_index);
    handles.thermal_index = cat(1, handles.axis_thermal_index, round(axis_thermal_file_index));
    
    display([file_index axis_rgb_file_index axis_thermal_file_index]);
    
    
    
    if (file_index == 1)
        %Initializing the previous frame by the current frame for next iteration
        axis_rgb_frame_prev = axis_rgb_frame;
        axis_thermal_frame_prev = axis_thermal_frame;
        kinect_rgb_frame_prev = kinect_rgb_frame;
        kinect_depth_frame_prev = kinect_depth_frame;
        continue;
    end %skipping movement analysis for the first iteration
    
    frame_diff = axis_rgb_frame-axis_rgb_frame_prev;
    axis_rgb_movement = cat(1, axis_rgb_movement, mean(mean(rgb2gray(frame_diff), 1), 2));
    frame_diff = axis_thermal_frame-axis_thermal_frame_prev;
    axis_thermal_movement = cat(1, axis_thermal_movement, mean(mean(rgb2gray(frame_diff), 1), 2));
    frame_diff = kinect_rgb_frame-kinect_rgb_frame_prev;
    kinect_rgb_movement = cat(1, kinect_rgb_movement, mean(mean(rgb2gray(frame_diff), 1), 2));
    frame_diff = kinect_depth_frame-kinect_depth_frame_prev;
    kinect_depth_movement = cat(1, kinect_depth_movement, mean(mean(frame_diff, 1), 2));
    % imshow(axis_thermal_frame_diff, 'Parent', handles.axes3);
    % pause(0.0001);
    
    %replacing the previous frame by the current frame for next iteration
    axis_rgb_frame_prev = axis_rgb_frame;
    axis_thermal_frame_prev = axis_thermal_frame;
    kinect_rgb_frame_prev = kinect_rgb_frame;
    kinect_depth_frame_prev = kinect_depth_frame;
    
    
    
    
    
    
    %showing images in the handle
    imshow(kinect_rgb_frame, 'Parent', handles.axes1);
    imshow(histeq(kinect_depth_frame), 'Parent', handles.axes2); %apply histequalization
    imshow(axis_rgb_frame, 'Parent', handles.axes3);
    imshow(axis_thermal_frame, 'Parent', handles.axes4);
    pause(0.0001); % Pause a fraction of a second to slow down the video.
    
    %     axes(handles.axes1); cla; imshow(axis_rgb_frame); hold on;
    %     imshow(histeq(axis_thermal_frame), 'Parent', handles.axes5); %apply histequalization
    %     imshow(flipdim(thermal_frame, 2), 'Parent', handles.axes4);
    
    
    %     %displaying to check time synchronization for kinect and axis modalites
    %     if (rem(file_index, 1000)==0)
    %     figure; imshow(axis_rgb_frame);
    %     figure; imshow(axis_thermal_frame);
    %     disp(handles.kinect_rgb_files(file_index).name(5:17));
    %     disp(handles.kinect_depth_files(file_index+kinect_file_index_adjust).name(3:15));
    %     end
    
    if (rem(file_index, 6000)==0)
        disp(handles.kinect_depth_files(file_index+kinect_file_index_adjust).name(3:15));
    end
    
end

% Update handles structure
guidata(hObject, handles);

display('Complete video exploration');


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%setting datapath
path = 'Data\sub1_day_exp_data\session001';

% Load frames for kinect
handles.kinect_rgb_files  = dir([handles.rgb_folder '*.jpg']);
handles.kinect_depth_files  = dir([handles.depth_folder '*.png']);
handles.axis_rgb_video  = dir([handles.axis_rgb_folder '*.mp4']);
handles.axis_thermal_video  = dir([handles.axis_thermal_folder '*.mp4']);

% open axis rgb and thermal video files for frame extraction
%axis_rgb_vid = VideoReader([handles.axis_rgb_folder '\1_2017-04-21_16-39-20_mpeg4.mp4']);
axis_rgb_vid = VideoReader([handles.axis_rgb_video.folder '\' handles.axis_rgb_video.name]);
axis_rgb_Fs = axis_rgb_vid.FrameRate; %ispy64 video edited to 30 fps by 'any video converter'
%axis_thermal_vid = VideoReader([handles.axis_thermal_folder '\2_2017-04-21_16-39-20_mpeg4.mp4']);
axis_thermal_vid = VideoReader([handles.axis_thermal_video.folder '\' handles.axis_thermal_video.name]);
axis_thermal_Fs = axis_thermal_vid.FrameRate; %ispy64 video edited to 30 fps by 'any video converter'


handles.file_index = 1;
kinect_file_index_adjust = 0; %added to depth file reading index to handle kinect rgb and depth file missing
axis_thermal_file_index = 1; %to match with kinect starting time
axis_rgb_file_index = 41; %to match with kinect starting time

%for saving the file reading sequence with synchronization
handles.kinect_rgb_index = [];
handles.kinect_depth_index = [];
handles.axis_rgb_index = [];
handles.axis_thermal_index = [];

%variables for movement analysis of patient
axis_rgb_frame_prev = []; %keeping the previous frame
axis_thermal_frame_prev = [];
kinect_rgb_frame_prev = [];
kinect_depth_frame_prev = [];
axis_thermal_frame_body_prev = [];

axis_rgb_movement = []; %keeping average movement of each frame over video
axis_thermal_movement = [];
kinect_rgb_movement = [];
kinect_depth_movement = [];
axis_thermal_movement_body = [];

for file_index = 1:(length(handles.kinect_rgb_files)-1)
    
    %calculating rgb and thermal frame index for axis videos from kinect frame rate
    next_frame_time = str2double(handles.kinect_rgb_files(file_index+1).name(11:12)) + ...
        str2double(handles.kinect_rgb_files(file_index+1).name(14:17))/10000.0;
    current_frame_time = str2double(handles.kinect_rgb_files(file_index).name(11:12)) + ...
        str2double(handles.kinect_rgb_files(file_index).name(14:17))/10000.0;
    if((next_frame_time-current_frame_time)>0)
        kinect_rgb_Fs = 1.0/(next_frame_time-current_frame_time);
    else
        kinect_rgb_Fs = 1.0/((60-current_frame_time)+next_frame_time);
    end
    axis_rgb_file_index = axis_rgb_file_index+(axis_rgb_Fs/kinect_rgb_Fs);
    axis_thermal_file_index = axis_thermal_file_index+(axis_thermal_Fs/kinect_rgb_Fs);
    
    %handling kinect rgb or depth frame missing by tracing in the future depth frames or skipping rgb frame
    if ~strcmp(handles.kinect_rgb_files(file_index).name(5:17), handles.kinect_depth_files(file_index+kinect_file_index_adjust).name(3:15))
        disp('before');
        disp(handles.kinect_rgb_files(file_index).name(5:17));
        disp(handles.kinect_depth_files(file_index+kinect_file_index_adjust).name(3:15));
        kinect_file_index_updated = 0; %to be used to handle kinect rgb and depth file missing
        %tracing in the future depth frames for the missing depth frame
        for i = 1:20
            if strcmp(handles.kinect_rgb_files(file_index).name(5:17), handles.kinect_depth_files(file_index+kinect_file_index_adjust+i).name(3:15))
                %found the corresponding depth frame, so proceed..
                kinect_file_index_adjust = kinect_file_index_adjust+i;
                kinect_file_index_updated = 1; %indicating that corresponding depth frame found
                break;
            end
        end
        disp('after');
        disp(handles.kinect_rgb_files(file_index).name(5:17));
        disp(handles.kinect_depth_files(file_index+kinect_file_index_adjust).name(3:15));
        if kinect_file_index_updated == 0
            %corresponding depth frame not found, so skipping the iteration for rgb, but keepiong the depth frame for next
            kinect_file_index_adjust = kinect_file_index_adjust-1;
            continue;
        end
    end
    
    %Avoiding file index out of limit error by stoping before exceeding
    if ((axis_thermal_file_index>=axis_thermal_vid.NumberOfFrame)||...
            (axis_rgb_file_index>=axis_rgb_vid.NumberOfFrame)||...
            ((file_index+kinect_file_index_adjust)>=length(handles.kinect_depth_files)))
        break;
    end
    
    
    %reading kinect rgb frame
    kinect_rgb_frame = imread([handles.rgb_folder handles.kinect_rgb_files(file_index).name]);
    
    %reading kinect depth frame
    kinect_depth_frame = imread([handles.depth_folder handles.kinect_depth_files(file_index+kinect_file_index_adjust).name]);
    
    %reading axis rgb frame
    axis_rgb_frame = flip(read(axis_rgb_vid, round(axis_rgb_file_index)), 2);
    
    %reading axis thermal frame
    axis_thermal_frame = flip(read(axis_thermal_vid, round(axis_thermal_file_index)), 2);
    
    
    %saving data in array to backtrack
    handles.kinect_rgb_index = cat(1, handles.kinect_rgb_index, file_index);
    handles.kinect_depth_index = cat(1, handles.kinect_depth_index, file_index);
    handles.axis_rgb_index = cat(1, handles.axis_rgb_index, axis_rgb_file_index);
    handles.thermal_index = cat(1, handles.axis_thermal_index, round(axis_thermal_file_index));
    
    display([file_index axis_rgb_file_index axis_thermal_file_index]);
    
    
    
    if (file_index == 1)
        %Initializing the previous frame by the current frame for next iteration
        axis_rgb_frame_prev = axis_rgb_frame;
        axis_thermal_frame_prev = axis_thermal_frame;
        kinect_rgb_frame_prev = kinect_rgb_frame;
        kinect_depth_frame_prev = kinect_depth_frame;
        
        axis_thermal_frame_body_prev = imcrop(axis_thermal_frame, bodyBlobDetect(axis_thermal_frame));
        
        continue;
    end %skipping movement analysis for the first iteration
    
    %recording movement by using whole frame
    frame_diff = axis_rgb_frame-axis_rgb_frame_prev;
    axis_rgb_movement = cat(1, axis_rgb_movement, mean(mean(rgb2gray(frame_diff), 1), 2));
    frame_diff = axis_thermal_frame-axis_thermal_frame_prev;
    axis_thermal_movement = cat(1, axis_thermal_movement, mean(mean(rgb2gray(frame_diff), 1), 2));
    frame_diff = kinect_rgb_frame-kinect_rgb_frame_prev;
    kinect_rgb_movement = cat(1, kinect_rgb_movement, mean(mean(rgb2gray(frame_diff), 1), 2));
    frame_diff = kinect_depth_frame-kinect_depth_frame_prev;
    kinect_depth_movement = cat(1, kinect_depth_movement, mean(mean(frame_diff, 1), 2));
    % imshow(axis_thermal_frame_diff, 'Parent', handles.axes3);
    % pause(0.0001);
    
    %recording movement from the body blob only
    body_blob_bbox = bodyBlobDetect(axis_thermal_frame);
    axis_thermal_frame_body = imcrop(axis_thermal_frame, body_blob_bbox);
    frame_diff = abs(mean(mean(rgb2gray(axis_thermal_frame_body), 1), 2) - mean(mean(rgb2gray(axis_thermal_frame_body_prev), 1), 2));
    axis_thermal_movement_body = cat(1, axis_thermal_movement_body, frame_diff);
    
    
    
    %replacing the previous frame by the current frame for next iteration
    axis_rgb_frame_prev = axis_rgb_frame;
    axis_thermal_frame_prev = axis_thermal_frame;
    kinect_rgb_frame_prev = kinect_rgb_frame;
    kinect_depth_frame_prev = kinect_depth_frame;
    axis_thermal_frame_body_prev = axis_thermal_frame_body;
    
    
    
    
    
    
    %showing images in the handle
    imshow(kinect_rgb_frame, 'Parent', handles.axes1);
    imshow(histeq(kinect_depth_frame), 'Parent', handles.axes2); %apply histequalization
    imshow(axis_rgb_frame, 'Parent', handles.axes3);
    imshow(axis_thermal_frame, 'Parent', handles.axes4);
    pause(0.0001); % Pause a fraction of a second to slow down the video.
    
    %     axes(handles.axes1); cla; imshow(axis_rgb_frame); hold on;
    %     imshow(histeq(axis_thermal_frame), 'Parent', handles.axes5); %apply histequalization
    %     imshow(flipdim(thermal_frame, 2), 'Parent', handles.axes4);
    
    
    %     %displaying to check time synchronization for kinect and axis modalites
    %     if (rem(file_index, 1000)==0)
    %     figure; imshow(axis_rgb_frame);
    %     figure; imshow(axis_thermal_frame);
    %     disp(handles.kinect_rgb_files(file_index).name(5:17));
    %     disp(handles.kinect_depth_files(file_index+kinect_file_index_adjust).name(3:15));
    %     end
    
    if (rem(file_index, 6000)==0)
        disp(handles.kinect_depth_files(file_index+kinect_file_index_adjust).name(3:15));
    end
    
end

% Update handles structure
guidata(hObject, handles);

display('Complete video exploration');


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%Splitting all videos

%setting datapath
path = 'Data\sub1_day_exp_data\session001';

% Load frames for kinect
handles.kinect_rgb_files  = dir([handles.rgb_folder '*.jpg']);
handles.kinect_depth_files  = dir([handles.depth_folder '*.png']);
handles.axis_rgb_video  = dir([handles.axis_rgb_folder '*.mp4']);
handles.axis_thermal_video  = dir([handles.axis_thermal_folder '*.mp4']);

% open axis rgb and thermal video files for frame extraction
%axis_rgb_vid = VideoReader([handles.axis_rgb_folder '\1_2017-04-21_16-39-20_mpeg4.mp4']);
axis_rgb_vid = VideoReader([handles.axis_rgb_video.folder '\' handles.axis_rgb_video.name]);
axis_rgb_Fs = axis_rgb_vid.FrameRate; %ispy64 video edited to 30 fps by 'any video converter'
%axis_thermal_vid = VideoReader([handles.axis_thermal_folder '\2_2017-04-21_16-39-20_mpeg4.mp4']);
axis_thermal_vid = VideoReader([handles.axis_thermal_video.folder '\' handles.axis_thermal_video.name]);
axis_thermal_Fs = axis_thermal_vid.FrameRate; %ispy64 video edited to 30 fps by 'any video converter'


handles.file_index = 1;
kinect_file_index_adjust = 0; %added to depth file reading index to handle kinect rgb and depth file missing

%To match with kinect starting time
%axis_thermal_file_index = 1843; axis_rgb_file_index = 1843; %for subject S01
% axis_thermal_file_index = 1020; axis_rgb_file_index = 1020; %for subject S02
% axis_thermal_file_index = 1248; axis_rgb_file_index = 1248; %for subject S02b
%axis_thermal_file_index = 3907; axis_rgb_file_index = 3907; %for subject S03
%axis_thermal_file_index = 1350; axis_rgb_file_index = 1350; %for subject S04
%axis_thermal_file_index = 2208; axis_rgb_file_index = 2208; %for subject S05
%axis_thermal_file_index = 1504; axis_rgb_file_index = 1504; %for subject S06
%axis_thermal_file_index = 10380; axis_rgb_file_index = 10380; %for subject S08 part1
%axis_thermal_file_index = 29143; axis_rgb_file_index = 29143; %for subject S08 part2
%axis_thermal_file_index = 2216; axis_rgb_file_index = 2216; %for subject S09
axis_thermal_file_index = 3449; axis_rgb_file_index = 3449; %for subject S10

%for saving the file reading sequence with synchronization
graph_roi = [];
handles.kinect_rgb_index = [];
handles.kinect_depth_index = [];
handles.axis_rgb_index = [];
handles.axis_thermal_index = [];
activity_event_switch = 0; %turning on when light is on
event_counter = 0;
inactivity_event_switch = 0;  %turning on for inactive time frame saving

%for file_index = 750:(length(handles.kinect_rgb_files)-1) %for subject S01
%for file_index = 112:(length(handles.kinect_rgb_files)-1) %for subject S02
%for file_index = 171:(length(handles.kinect_rgb_files)-1) %for subject S02b
%for file_index = 2490:(length(handles.kinect_rgb_files)-1) %for subject S03
%for file_index = 268:(length(handles.kinect_rgb_files)-1) %for subject S04
%for file_index = 1100:(length(handles.kinect_rgb_files)-1) %for subject S05
%for file_index = 320:(length(handles.kinect_rgb_files)-1) %for subject S06
%for file_index = 7341:(length(handles.kinect_rgb_files)-1) %for subject S08 part1
%for file_index = 125:7340 %for subject S08 part2
%for file_index = 876:(length(handles.kinect_rgb_files)-1) %for subject S09
for file_index = 2056:(length(handles.kinect_rgb_files)-1) %for subject S10
    
    %calculating rgb and thermal frame index for axis videos from kinect frame rate
    next_frame_time = str2double(handles.kinect_rgb_files(file_index+1).name(11:12)) + ...
        str2double(handles.kinect_rgb_files(file_index+1).name(14:17))/10000.0;
    current_frame_time = str2double(handles.kinect_rgb_files(file_index).name(11:12)) + ...
        str2double(handles.kinect_rgb_files(file_index).name(14:17))/10000.0;
    if((next_frame_time-current_frame_time)>0)
        kinect_rgb_Fs = 1.0/(next_frame_time-current_frame_time);
    else
        kinect_rgb_Fs = 1.0/((60-current_frame_time)+next_frame_time);
    end
    axis_rgb_file_index = axis_rgb_file_index+(axis_rgb_Fs/kinect_rgb_Fs);
    axis_thermal_file_index = axis_thermal_file_index+(axis_thermal_Fs/kinect_rgb_Fs);
    
    %handling kinect rgb or depth frame missing by tracing in the future depth frames or skipping rgb frame
    if ~strcmp(handles.kinect_rgb_files(file_index).name(5:17), handles.kinect_depth_files(file_index+kinect_file_index_adjust).name(3:15))
        disp('before');
        disp(handles.kinect_rgb_files(file_index).name(5:17));
        disp(handles.kinect_depth_files(file_index+kinect_file_index_adjust).name(3:15));
        kinect_file_index_updated = 0; %to be used to handle kinect rgb and depth file missing
        %tracing in the future depth frames for the missing depth frame
        for i = 1:20
            if strcmp(handles.kinect_rgb_files(file_index).name(5:17), handles.kinect_depth_files(file_index+kinect_file_index_adjust+i).name(3:15))
                %found the corresponding depth frame, so proceed..
                kinect_file_index_adjust = kinect_file_index_adjust+i;
                kinect_file_index_updated = 1; %indicating that corresponding depth frame found
                break;
            end
        end
        disp('after');
        disp(handles.kinect_rgb_files(file_index).name(5:17));
        disp(handles.kinect_depth_files(file_index+kinect_file_index_adjust).name(3:15));
        if kinect_file_index_updated == 0
            %corresponding depth frame not found, so skipping the iteration for rgb, but keepiong the depth frame for next
            kinect_file_index_adjust = kinect_file_index_adjust-1;
            continue;
        end
    end
    
    %Avoiding file index out of limit error by stoping before exceeding
    if ((axis_thermal_file_index>=axis_thermal_vid.NumberOfFrame)||...
            (axis_rgb_file_index>=axis_rgb_vid.NumberOfFrame)||...
            ((file_index+kinect_file_index_adjust)>=length(handles.kinect_depth_files)))
        break;
    end
    
    
    %reading kinect rgb frame
    kinect_rgb_frame = imread([handles.rgb_folder handles.kinect_rgb_files(file_index).name]);
    
    %reading kinect depth frame
    kinect_depth_frame = imread([handles.depth_folder handles.kinect_depth_files(file_index+kinect_file_index_adjust).name]);
    
    %reading axis rgb frame
    axis_rgb_frame = flip(read(axis_rgb_vid, round(axis_rgb_file_index)), 2);
    
    %reading axis thermal frame
    axis_thermal_frame = flip(read(axis_thermal_vid, round(axis_thermal_file_index)), 2);
    
    
    %saving data in array to backtrack
    handles.kinect_rgb_index = cat(1, handles.kinect_rgb_index, file_index);
    handles.kinect_depth_index = cat(1, handles.kinect_depth_index, file_index);
    handles.axis_rgb_index = cat(1, handles.axis_rgb_index, axis_rgb_file_index);
    handles.thermal_index = cat(1, handles.axis_thermal_index, round(axis_thermal_file_index));
    
%         %showing images in the handle
%         imshow(kinect_rgb_frame, 'Parent', handles.axes1);
%         imshow(histeq(kinect_depth_frame), 'Parent', handles.axes2); %apply histequalization
%         imshow(axis_rgb_frame, 'Parent', handles.axes3);
%         imshow(axis_thermal_frame, 'Parent', handles.axes4);
%         pause(0.0001); % Pause a fraction of a second to slow down the video.
    
    %     axes(handles.axes1); cla; imshow(axis_rgb_frame); hold on;
    %     imshow(histeq(axis_thermal_frame), 'Parent', handles.axes5); %apply histequalization
    %     imshow(flipdim(thermal_frame, 2), 'Parent', handles.axes4);
    
    display([file_index axis_rgb_file_index axis_thermal_file_index]);
    
    %     %displaying to check time synchronization for kinect and axis modalites
    %     if (rem(file_index, 1000)==0)
    %     figure; imshow(axis_rgb_frame);
    %     figure; imshow(axis_thermal_frame);
    %     disp(handles.kinect_rgb_files(file_index).name(5:17));
    %     disp(handles.kinect_depth_files(file_index+kinect_file_index_adjust).name(3:15));
    %     end
    
    
    % assuing indicator roi is at rectangle position
%    indicator_roi = kinect_rgb_frame(630:630+8, 1359:1359+8, :); %subject S01
%    indicator_roi = kinect_rgb_frame(622:622+10, 1270:1270+10, :); %subject S02
%    indicator_roi = kinect_rgb_frame(630:630+8, 1359:1359+8, :); %subject S02b
%    indicator_roi = kinect_rgb_frame(635:635+8, 1359:1359+8, :); %subject S03
%    indicator_roi = kinect_rgb_frame(635:635+8, 1359:1359+8, :); %subject S04
%    indicator_roi = kinect_rgb_frame(633:633+8, 1357:1357+8, :); %subject S05
    indicator_roi = kinect_rgb_frame(633:633+8, 1357:1357+8, :); %subject S06, S08, S09, 10
    imshow(indicator_roi, 'Parent', handles.axes5);
    %finding pain indicator on/off
    mean_roi = mean(indicator_roi(:))
    graph_roi = cat(1, graph_roi, mean_roi);
    %mean_channel = squeeze(mean(mean(indicator_roi(:, :, 1:3))));
    
    %%%%if pain indicator is on, save data
    
    roi_threshold = 200;
    if(mean_roi > roi_threshold)
        if (activity_event_switch == 0)
            activity_event_switch = 1;
            inactivity_event_switch = 0; %resetting for inactivity
            event_counter = event_counter+1;
            
            kinect_rgb_save_path = [handles.root_folder '\events\event' num2str(event_counter) '\kinect_rgb'];
            mkdir(kinect_rgb_save_path);
            kinect_depth_save_path = [handles.root_folder '\events\event' num2str(event_counter) '\kinect_depth'];
            mkdir(kinect_depth_save_path);
            axis_rgb_save_path = [handles.root_folder '\events\event' num2str(event_counter) '\axis_rgb'];
            mkdir(axis_rgb_save_path);
            axis_thermal_save_path = [handles.root_folder '\events\event' num2str(event_counter) '\axis_thermal'];
            mkdir(axis_thermal_save_path);
        end
        
        imwrite(kinect_rgb_frame, [kinect_rgb_save_path '\kinect-' handles.kinect_rgb_files(file_index).name]);
        imwrite(kinect_depth_frame, [kinect_depth_save_path '\kinect-' handles.kinect_depth_files(file_index+kinect_file_index_adjust).name]);
        imwrite(axis_rgb_frame, [axis_rgb_save_path '\axis-' handles.kinect_rgb_files(file_index).name]);
        imwrite(axis_thermal_frame, [axis_thermal_save_path '\axis-T' handles.kinect_rgb_files(file_index).name(4:end)]);
        
        %showing images in the handle
        imshow(kinect_rgb_frame, 'Parent', handles.axes1);
        imshow(histeq(kinect_depth_frame), 'Parent', handles.axes2); %apply histequalization
        imshow(axis_rgb_frame, 'Parent', handles.axes3);
        imshow(axis_thermal_frame, 'Parent', handles.axes4);
        pause(0.000001); % Pause a fraction of a second to slow down the video.
        
    else
        activity_event_switch = 0;
        inactivity_event_switch = inactivity_event_switch+1;
        if((event_counter~=0)&&((inactivity_event_switch>5)&&(inactivity_event_switch<50)))
            if(inactivity_event_switch==6) %creating directory
                kinect_rgb_save_path = [handles.root_folder '\events\inactivity_event' num2str(event_counter) '\kinect_rgb'];
                mkdir(kinect_rgb_save_path);
                kinect_depth_save_path = [handles.root_folder '\events\inactivity_event' num2str(event_counter) '\kinect_depth'];
                mkdir(kinect_depth_save_path);
                axis_rgb_save_path = [handles.root_folder '\events\inactivity_event' num2str(event_counter) '\axis_rgb'];
                mkdir(axis_rgb_save_path);
                axis_thermal_save_path = [handles.root_folder '\events\inactivity_event' num2str(event_counter) '\axis_thermal'];
                mkdir(axis_thermal_save_path);
                
            end
            
            %saving data
            imwrite(kinect_rgb_frame, [kinect_rgb_save_path '\kinect-' handles.kinect_rgb_files(file_index).name]);
            imwrite(kinect_depth_frame, [kinect_depth_save_path '\kinect-' handles.kinect_depth_files(file_index+kinect_file_index_adjust).name]);
            imwrite(axis_rgb_frame, [axis_rgb_save_path '\axis-' handles.kinect_rgb_files(file_index).name]);
            imwrite(axis_thermal_frame, [axis_thermal_save_path '\axis-T' handles.kinect_rgb_files(file_index).name(4:end)]);
            
            %showing images in the handle
            imshow(kinect_rgb_frame, 'Parent', handles.axes1);
            imshow(histeq(kinect_depth_frame), 'Parent', handles.axes2); %apply histequalization
            imshow(axis_rgb_frame, 'Parent', handles.axes3);
            imshow(axis_thermal_frame, 'Parent', handles.axes4);
            pause(0.000001); % Pause a fraction of a second to slow down the video.
            
            
        end
    end
    
    %     if file_index > (length(handles.rgb_files)-5)
    %         figure; plot(graph_roi);
    %         hold on;
    %         plot(handles.rgb_start_index(:, 1), graph_roi(1, :), 'Marker', '+', 'Color', 'r');
    %         hold off;
    %         break;
    %     end
    %
    
    
end

% Update handles structure
guidata(hObject, handles);

display('Complete video exploration');


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%data root setting
data_folder_path  = 'D:\Hammel Research\Hammel Pilot data\Annotated_Data\';
data_folders  = dir(data_folder_path);
data_folders  = data_folders(3:end);

%variable for saving extracted features for further analysis
all_class_labels = [];
all_event_features = [];
all_class_size = zeros(1, 7); % here 7 is the number of classess

%Accessing the annotated data of each subject, each event and each modality
for sub_id = 1:length(data_folders)
    display(sub_id);
    
    subject_folder_path = [data_folder_path data_folders(sub_id).name];
    subject_folder = dir(subject_folder_path);
    subject_folder = subject_folder(3:end);
    
    %accessing the events of each subject
    for event_id = 1: length(subject_folder)
        display(event_id);
        
        event_folder_path = [subject_folder_path '\' subject_folder(event_id).name];
        
        %accessing the containing folders of frames
        kinect_rgb_path = [event_folder_path '\kinect_rgb\'];
        kinect_rgb_files  = dir([kinect_rgb_path '*.jpg']);
        
        kinect_depth_path = [event_folder_path '\kinect_depth\'];
        kinect_depth_files  = dir([kinect_depth_path '*.png']);
        
        axis_rgb_path = [event_folder_path '\axis_rgb\'];
        axis_rgb_files  = dir([axis_rgb_path '*.jpg']);
        
        axis_thermal_path = [event_folder_path '\axis_thermal\'];
        axis_thermal_files  = dir([axis_thermal_path '*.jpg']);
        
        
        %employing KLT tracker on GFT on the bed roi region only for axis_rgb
        roi_coords = [160 130 275 270]; %manually cropped bed region as roi
        [xLocPointTraces, yLocPointTraces, pointTraces] = trackPointsLKTbyGFT( axis_rgb_path, axis_rgb_files, roi_coords );
        LKTpointdiff = sqrt((diff(xLocPointTraces, 1, 2).^2)+(diff(yLocPointTraces, 1, 2).^2)); %calculaing Euclidian distance traces
        %        figure; surf(movmean(movmean(pointdiff, 15, 2), 15, 1)); shading interp;
        
        %Window based motion analysis in extracted motion traces using KLT
        %Dividing the 2-D LKT first differential image into grid along points direction only
        gridSize= 20; %setting the number of cells in each direction of the grid
        xStep = 1; %Keeping all tracked points in each grid cell
        yStep = (size(LKTpointdiff, 2)/gridSize); %Keeping 5% of frames in each grid cell
        LKTpointdiff_grid = zeros(size(LKTpointdiff, 1), gridSize);
        for startX = 1 : size(LKTpointdiff, 1)
            
            for startY =1 : gridSize
                cell_data = LKTpointdiff(startX, (floor((startY-1)*yStep)+1):(floor(startY*yStep)));
                LKTpointdiff_grid(startX, startY) = mean(mean(cell_data));
            end
            
        end
        %         figure; surf(LKTpointdiff_grid); shading interp;
        
        %employing PCA on Radon image for feature dimension reduction
        [pcaCoeff,pcaScore,pcaLatent,~,pcaExplained] = pca(LKTpointdiff_grid');
        pcaFeature = LKTpointdiff_grid'*pcaCoeff;
        pcaFeature_10 = pcaFeature(:, 1:10);
        
        
        %         %saving all groups in all scenarios
        %         all_event_features = cat(2, all_event_features, pcaFeature_10(:));
        %         all_class_labels = cat(1, all_class_labels, (str2num(event_folder_path(end))+1));
        %         all_class_size((str2num(event_folder_path(end))+1))= all_class_size((str2num(event_folder_path(end))+1))+1;
        
        %saving 3 umbrella group in all scenarios
        all_event_features = cat(2, all_event_features, pcaFeature_10(:));
        all_class_size= all_class_size(1:3);
        if(((str2num(event_folder_path(end))+1)==1)||((str2num(event_folder_path(end))+1)==2)||((str2num(event_folder_path(end))+1)==3))
            all_class_labels = cat(1, all_class_labels, 1);
            all_class_size(1)= all_class_size(1)+1;
        elseif (((str2num(event_folder_path(end))+1)==4)||((str2num(event_folder_path(end))+1)==5))
            all_class_labels = cat(1, all_class_labels, 2);
            all_class_size(2)= all_class_size(2)+1;
        else
            all_class_labels = cat(1, all_class_labels, 3);
            all_class_size(3)= all_class_size(3)+1;
        end
        
        
        
        %         %Window based motion analysis in extracted motion traces using KLT
        %         %Dividing the 2-D LKT first differential image into grid
        %         gridSize= 20; %setting the number of cells in each direction of the grid
        %         xStep = (size(LKTpointdiff(), 1)/gridSize); %Keeping 5% of points in each grid cell
        %         yStep = (size(LKTpointdiff(), 2)/gridSize); %Keeping 5% of frames in each grid cell
        %         LKTpointdiff_grid = zeros(gridSize, gridSize);
        %         for startX = 1 : gridSize
        %
        %             for startY =1 : gridSize
        %                 cell_data = LKTpointdiff((floor((startX-1)*xStep)+1):(floor(startX*xStep)), ...
        %                     (floor((startY-1)*yStep)+1):(floor(startY*yStep)));
        %                 LKTpointdiff_grid(startX, startY) = mean(mean(cell_data));
        %             end
        %
        %         end
        % %         figure; surf(LKTpointdiff_grid); shading interp;
        % %         %saving all groups in all scenarios
        % %         all_event_features = cat(2, all_event_features, LKTpointdiff_grid(:));
        % %         all_class_labels = cat(1, all_class_labels, (str2num(event_folder_path(end))+1));
        % %         all_class_size((str2num(event_folder_path(end))+1))= all_class_size((str2num(event_folder_path(end))+1))+1;
        %
        %         %saving 3 umbrella group in all scenarios
        %         all_event_features = cat(2, all_event_features, LKTpointdiff_grid(:));
        %         all_class_size= all_class_size(1:3);
        %         if(((str2num(event_folder_path(end))+1)==1)||((str2num(event_folder_path(end))+1)==2)||((str2num(event_folder_path(end))+1)==3))
        %             all_class_labels = cat(1, all_class_labels, 1);
        %             all_class_size(1)= all_class_size(1)+1;
        %         elseif (((str2num(event_folder_path(end))+1)==4)||((str2num(event_folder_path(end))+1)==5))
        %             all_class_labels = cat(1, all_class_labels, 2);
        %             all_class_size(2)= all_class_size(2)+1;
        %         else
        %             all_class_labels = cat(1, all_class_labels, 3);
        %             all_class_size(3)= all_class_size(3)+1;
        %         end
        
        
        
        
        %         %employing Radon transform for motion regions filtering over angle of raw feature data
        %         theta = 0:180; %number of angles
        %         [radonImage,xp] = radon(LKTpointdiff,theta);
        %         % imshow(R,[],'Xdata',theta,'Ydata',xp,...
        %         %             'InitialMagnification','fit')
        %         % xlabel('\theta (degrees)')
        %         % ylabel('x''')
        %         %dist = pdist(R); %calculating p-to-p distance of radon pixels as features
        %
        %         %employing PCA on Radon image for feature dimension reduction
        %         [pcaCoeff,pcaScore,pcaLatent,~,pcaExplained] = pca(radonImage');
        %         pcaFeature = radonImage'*pcaCoeff;
        %
        %         %saving features for further processing
        %         %saving all groups in all scenarios
        %         all_event_features = cat(2, all_event_features, pcaFeature(:));
        %         all_class_labels = cat(1, all_class_labels, (str2num(event_folder_path(end))+1));
        %         all_class_size((str2num(event_folder_path(end))+1))= all_class_size((str2num(event_folder_path(end))+1))+1;
        
        %         %saving non-blanket scenario only for all group
        %         if(str2num(event_folder_path(end-2))==1)
        %             all_event_features = cat(2, all_event_features, pcaFeature(:));
        %             all_class_labels = cat(1, all_class_labels, (str2num(event_folder_path(end))+1));
        %             all_class_size((str2num(event_folder_path(end))+1))= all_class_size((str2num(event_folder_path(end))+1))+1;
        %         end
        %
        %         %saving 3 umbrella group in all scenarios
        %         all_event_features = cat(2, all_event_features, pcaFeature(:));
        %         all_class_size= all_class_size(1:3);
        %         if(((str2num(event_folder_path(end))+1)==1)||((str2num(event_folder_path(end))+1)==2)||((str2num(event_folder_path(end))+1)==3))
        %             all_class_labels = cat(1, all_class_labels, 1);
        %             all_class_size(1)= all_class_size(1)+1;
        %         elseif (((str2num(event_folder_path(end))+1)==4)||((str2num(event_folder_path(end))+1)==5))
        %             all_class_labels = cat(1, all_class_labels, 2);
        %             all_class_size(2)= all_class_size(2)+1;
        %         else
        %             all_class_labels = cat(1, all_class_labels, 3);
        %             all_class_size(3)= all_class_size(3)+1;
        %         end
        
        
        disp('temp');
        
        
        %         if (rem(sync_file_index, 6000)==0)
        %             disp('temporary stop');
        %         end
        
    end
    
end
save('rough_data_gridPCA10group3.mat', 'all_event_features', 'all_class_labels', 'all_class_size');
[confusionMat, accuracy, classifiers] = classificationFramework(all_event_features, all_class_labels, all_class_size);
disp('temp');

% Update handles structure
guidata(hObject, handles);

display('Complete video exploration');


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%data root setting
data_folder_path  = 'D:\Hammel Research\Hammel Pilot data\Annotated_Data\';
data_folders  = dir(data_folder_path);
data_folders  = data_folders(3:end);

%variable for saving extracted features for further analysis
all_class_labels = [];
all_event_features = [];
all_event_features_resize = [];
all_event_features_PCA = [];
all_event_features_gridResize = [];
all_event_features_gridPCA = [];
all_event_features_radon = [];
all_event_features_radonP2P = [];
all_event_features_radonPCA = [];
all_class_size = zeros(1, 8); % here 8 is the number of classess

%selection of feature generation attributes
group_numbers = 0; %all conditions=0, 8motions=8 4motions=4 (no, small, moderate, large)
blanket = 0; %all=0, no=1, yes=2
extract_feature = 0; %all=0, extract_resize=1, etc as below
cropping = 'manual'; % 'manual' or 'no' or 'body'

%feature extraction options
extract_resize = 1;
extract_PCA = 2;
extract_gridResize = 3;
extract_gridPCA = 4;
extract_radon = 5;
extract_radonP2P = 6; %radon point to point distance
extract_radonPCA = 7;




%Accessing the annotated data of each subject, each event and each modality
for sub_id = 1:length(data_folders)
    display(sub_id);
    
    subject_folder_path = [data_folder_path data_folders(sub_id).name];
    subject_folder = dir(subject_folder_path);
    subject_folder = subject_folder(3:end);
    
    %accessing the events of each subject
    for event_id = 1: length(subject_folder)
        display(event_id);
        
        %checking if all data needs to be processed including blanket on/off
        if ((blanket~=0)&&(str2num(subject_folder(event_id).name(end-2))~=blanket))
            continue;
        end
        
        event_folder_path = [subject_folder_path '\' subject_folder(event_id).name];
        
        %accessing the containing folders of frames
        kinect_rgb_path = [event_folder_path '\kinect_rgb\'];
        kinect_rgb_files  = dir([kinect_rgb_path '*.jpg']);
        
        kinect_depth_path = [event_folder_path '\kinect_depth\'];
        kinect_depth_files  = dir([kinect_depth_path '*.png']);
        
        axis_rgb_path = [event_folder_path '\axis_rgb\'];
        axis_rgb_files  = dir([axis_rgb_path '*.jpg']);
        
        axis_thermal_path = [event_folder_path '\axis_thermal\'];
        axis_thermal_files  = dir([axis_thermal_path '*.jpg']);
        
        
        %employing KLT tracker on GFT on the bed roi region only for axis_rgb
        roi_coords = [210 220 145 140]; %manually cropped bed region as roi
        [xLocPointTraces, yLocPointTraces, pointTraces] = trackPointsLKTbyGFT( kinect_depth_path, kinect_depth_files, roi_coords );
        LKTpointdiff = sqrt((diff(xLocPointTraces, 1, 2).^2)+(diff(yLocPointTraces, 1, 2).^2)); %calculaing Euclidian distance traces
        %        figure; surf(movmean(movmean(pointdiff, 15, 2), 15, 1)); shading interp;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if ((extract_feature==0)||(extract_feature==extract_resize))
            disp('Feature for extract_resize complete');
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if ((extract_feature==0)||(extract_feature==extract_PCA))
            disp('Feature for extract_pca complete');
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if ((extract_feature==0)||(extract_feature==extract_gridResize))
            %Spatial window based motion analysis in extracted motion traces using KLT
            %Dividing the 2-D LKT first differential image into grid in both axis
            gridSize= [50 50]; %setting the [row col] in the grid
            LKTpointdiff_grid = resizem(LKTpointdiff, gridSize, 'bicubic');
            %             gridSize= 20; %setting the number of cells in each direction of the grid
            %             xStep = (size(LKTpointdiff, 1)/gridSize); %Keeping all tracked points in each grid cell
            %             yStep = (size(LKTpointdiff, 2)/gridSize); %Keeping 5% of frames in each grid cell
            %             LKTpointdiff_grid = zeros(size(gridSize, gridSize));
            %             for startX = 1 : gridSize
            %                 for startY =1 : gridSize
            %                     cell_data = LKTpointdiff((floor((startX-1)*xStep)+1):(floor(startX*xStep)), ...
            %                         (floor((startY-1)*yStep)+1):(floor(startY*yStep)));
            %                     LKTpointdiff_grid(startX, startY) = mean(mean(cell_data));
            %                 end
            %             end
            %figure; surf(LKTpointdiff_grid); shading interp;
            
            %saving all groups in all scenarios
            all_event_features_gridResize = cat(2, all_event_features_gridResize, LKTpointdiff_grid(:));
            disp('Feature for extract_gridResize complete');
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if ((extract_feature==0)||(extract_feature==extract_gridPCA))
            %Spatial window based motion analysis in extracted motion traces using KLT
            %Dividing the 2-D LKT first differential image into grid along points direction only
            gridSize= [size(LKTpointdiff, 1) 50]; %setting the [row col] in the grid
            LKTpointdiff_grid = resizem(LKTpointdiff, gridSize, 'bicubic');
            %figure; surf(LKTpointdiff_grid); shading interp;
            
            %employing PCA on the grid for feature dimension reduction along movement direction
            [pcaCoeff,pcaScore,pcaLatent,~,pcaExplained] = pca(LKTpointdiff_grid');
            pcaFeature_all = LKTpointdiff_grid'*pcaCoeff;
            pca_amount = 10; %taking different amount of pca information
            pcaFeature = pcaFeature_all(:, 1:pca_amount);
            
            %saving all groups in all scenarios
            all_event_features_gridPCA = cat(2, all_event_features_gridPCA, pcaFeature(:));
            disp('Feature for extract_gridPCA complete');
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        if ((extract_feature==0)||(extract_feature==extract_radon))
            %employing Radon transform for motion regions filtering over angle of raw feature data
            theta = 0:180; %number of angles
            [radonImage,xp] = radon(LKTpointdiff,theta);
            % imshow(radonImage,[],'Xdata',theta,'Ydata',xp,...
            %             'InitialMagnification','fit')
            % xlabel('\theta (degrees)')
            % ylabel('x''')
            
            %Resizing the radon image to match in all sequence for equal feature vector
            gridSize= [50 size(radonImage, 2)]; %setting the [row col] in the grid
            radonFeature = resizem(radonImage, gridSize, 'bicubic');
            
            %saving all groups in all scenarios
            all_event_features_radon = cat(2, all_event_features_radon, radonFeature(:));
            disp('Feature for extract_radon complete');
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if ((extract_feature==0)||(extract_feature==extract_radonP2P))
            %employing Radon transform for motion regions filtering over angle of raw feature data
            theta = 0:180; %number of angles
            [radonImage,xp] = radon(LKTpointdiff,theta);
            % imshow(radonImage,[],'Xdata',theta,'Ydata',xp,...
            %             'InitialMagnification','fit')
            % xlabel('\theta (degrees)')
            % ylabel('x''')
            
            %Resizing the radon image to match in all sequence for equal feature vector
            gridSize= [50 size(radonImage, 2)]; %setting the [row col] in the grid
            radonImage = resizem(radonImage, gridSize, 'bicubic');
            
            radonFeature = pdist(radonImage); %calculating p-to-p distance of radon pixels as features
            
            %saving all groups in all scenarios
            all_event_features_radonP2P = cat(2, all_event_features_radonP2P, radonFeature(:));
            disp('Feature for extract_radonP2P complete');
        end
        
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         if ((extract_feature==0)||(extract_feature==extract_radonPCA))
%             %employing Radon transform for motion regions filtering over angle of raw feature data
%             theta = 0:180; %number of angles
%             [radonImage,xp] = radon(LKTpointdiff,theta);
%             % imshow(radonImage,[],'Xdata',theta,'Ydata',xp,...
%             %             'InitialMagnification','fit')
%             % xlabel('\theta (degrees)')
%             % ylabel('x''')
%             
%             %employing PCA on Radon image for feature dimension reduction
%             [pcaCoeff,pcaScore,pcaLatent,~,pcaExplained] = pca(radonImage');
%             pcaRadonFeature = radonImage'*pcaCoeff;
%             
%             %saving all groups in all scenarios
%             all_event_features_radonPCA = cat(2, all_event_features_radonPCA, pcaRadonFeature(:));
%             disp('Feature for extract_radonPCA complete');
%         end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        all_class_labels = cat(1, all_class_labels, (str2num(event_folder_path(end))+1));
        all_class_size((str2num(event_folder_path(end))+1))= all_class_size((str2num(event_folder_path(end))+1))+1;
        
        disp('temp');
        %         if (rem(sync_file_index, 6000)==0)
        %             disp('temporary stop');
        %         end
        
    end
    
end


%%%%%%%%%%%%%%%%if all groups are not considered%%%%%%%%%%%%%%%%%%%
if (group_numbers==4) %four groups with varying motion
    %saving 4 umbrella group in all scenarios (no, small, moderate, large motions)
    all_class_size= zeros(1, 4);
    for event_id = 1: length(all_class_labels)
        if((all_class_labels(event_id)==2)||(all_class_labels(event_id)==3)||(all_class_labels(event_id)==4))
            all_class_labels(event_id) = 2; %for small motion
        elseif ((all_class_labels(event_id)==5)||(all_class_labels(event_id)==6))
            all_class_labels(event_id) = 3; %for moderate motion
        elseif ((all_class_labels(event_id)==7)||(all_class_labels(event_id)==8))
            all_class_labels(event_id) = 4; %for large motion
        else
            all_class_labels(event_id) = 1; %for no motion
        end
        all_class_size(all_class_labels(event_id))= all_class_size(all_class_labels(event_id))+1;
    end
end


%%%%%%%%%%%%Saving the features%%%%%%%%%%%%%%%%%
if ((extract_feature==0)||(extract_feature==extract_resize))
    all_event_features = all_event_features_resize;
    if ((group_numbers==0)||(group_numbers==8)) %for all as 8 is the total groups
        save(['feature_' cropping '_cropped_resize_all.mat'], 'all_event_features', 'all_class_labels', 'all_class_size');
    end
    if ((group_numbers==0)||(group_numbers==4)) %four groups with varying motion
        save(['feature_' cropping '_cropped_resize_4groups.mat'], 'all_event_features', 'all_class_labels', 'all_class_size');
    end
end

if ((extract_feature==0)||(extract_feature==extract_PCA))
    all_event_features = all_event_features_PCA;
    if ((group_numbers==0)||(group_numbers==8)) %for all as 8 is the total groups
        save(['feature_' cropping '_cropped_PCA' num2str(pca_amount) '_all.mat'], 'all_event_features', 'all_class_labels', 'all_class_size');
    end
    if ((group_numbers==0)||(group_numbers==4)) %four groups with varying motion
        save(['feature_' cropping '_cropped_PCA' num2str(pca_amount) '_4groups.mat'], 'all_event_features', 'all_class_labels', 'all_class_size');
    end
end

if ((extract_feature==0)||(extract_feature==extract_gridResize))
    all_event_features = all_event_features_gridResize;
    if ((group_numbers==0)||(group_numbers==8)) %for all as 8 is the total groups
        save(['feature_' cropping '_cropped_gridResize_all.mat'], 'all_event_features', 'all_class_labels', 'all_class_size');
    end
    if ((group_numbers==0)||(group_numbers==4)) %four groups with varying motion
        save(['feature_' cropping '_cropped_gridResize_4groups.mat'], 'all_event_features', 'all_class_labels', 'all_class_size');
    end
end

if ((extract_feature==0)||(extract_feature==extract_gridPCA))
    all_event_features = all_event_features_gridPCA;
    if ((group_numbers==0)||(group_numbers==8)) %for all as 8 is the total groups
        save(['feature_' cropping '_cropped_gridPCA' num2str(pca_amount) '_all.mat'], 'all_event_features', 'all_class_labels', 'all_class_size');
    end
    if ((group_numbers==0)||(group_numbers==4)) %four groups with varying motion
        save(['feature_' cropping '_cropped_gridPCA' num2str(pca_amount) '_4groups.mat'], 'all_event_features', 'all_class_labels', 'all_class_size');
    end
end

if ((extract_feature==0)||(extract_feature==extract_radon))
    all_event_features = all_event_features_radon;
    if ((group_numbers==0)||(group_numbers==8)) %for all as 8 is the total groups
        save(['feature_' cropping '_cropped_radon_all.mat'], 'all_event_features', 'all_class_labels', 'all_class_size');
    end
    if ((group_numbers==0)||(group_numbers==4)) %four groups with varying motion
        save(['feature_' cropping '_cropped_radon_4groups.mat'], 'all_event_features', 'all_class_labels', 'all_class_size');
    end
end

if ((extract_feature==0)||(extract_feature==extract_radonP2P))
    all_event_features = all_event_features_radonP2P;
    if ((group_numbers==0)||(group_numbers==8)) %for all as 8 is the total groups
        save(['feature_' cropping '_cropped_radonP2P_all.mat'], 'all_event_features', 'all_class_labels', 'all_class_size');
    end
    if ((group_numbers==0)||(group_numbers==4)) %four groups with varying motion
        save(['feature_' cropping '_cropped_radonP2P_4groups.mat'], 'all_event_features', 'all_class_labels', 'all_class_size');
    end
end

if ((extract_feature==0)||(extract_feature==extract_radonPCA))
    all_event_features = all_event_features_radonPCA;
    if ((group_numbers==0)||(group_numbers==8)) %for all as 8 is the total groups
        save(['feature_' cropping '_cropped_radonPCA_all.mat'], 'all_event_features', 'all_class_labels', 'all_class_size');
    end
    if ((group_numbers==0)||(group_numbers==4)) %four groups with varying motion
        save(['feature_' cropping '_cropped_radonPCA_4groups.mat'], 'all_event_features', 'all_class_labels', 'all_class_size');
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




save('rough_data_gridPCA10group3.mat', 'all_event_features', 'all_class_labels', 'all_class_size');
[confusionMat, accuracy, classifiers] = classificationFramework(all_event_features, all_class_labels, all_class_size);
disp('temp');

% Update handles structure
guidata(hObject, handles);

display('Complete video exploration');
