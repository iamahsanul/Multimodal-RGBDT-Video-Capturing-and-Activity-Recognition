%%This file will read the annotated data and synchronized the RGBDT
%%framerates along with face detection (using haar features) from rgb and getting homographic
%%face bounding box from RGB to D and T modalities. So the output
%%parameters you can get from here are:
%      rgb_frame         - RGB frame of the subject
%      thermal_frame     - thermal frame corresponding to the RGB frame
%      depth_frame       - depth frame corresponding to the RGB frame
%      rgb_bbox          - face region in the rgb frame in a 1x4 matrix
%                          rgb_bbox = [corner_x, corner_y, width, height]
%      th_bbox           - face region in thermal frame as rgb_bbox
%      depth_bbox        - face region in depth frame as rgb_bbox
%
%If face is misdetected you can write a condition statement to check if the
%face size is in expected level from the width and height of the face. If
%no than you can discard that as a misdetection. 
%
%Author: Mohammad A. Haque, Email: iamahsanul@gmail.com


%data root setting
data_folder_path  = 'D:\RGBDT Pain Detection\RGBDT Database\Annotated_data\';
data_folders  = dir(data_folder_path);
data_folders = data_folders(3:end-8);

%Accessing the annotated data of each subject, each trial and each sweep
for sub_id = 1:length(data_folders)
    display(sub_id);
    
    subject_folder_path = [data_folder_path data_folders(sub_id).name];
    subject_folder = dir(subject_folder_path);
    subject_folder = subject_folder(3:end);
    
    %accessing the trials of each subject
    for trial_id = 1: length(subject_folder)
        display(trial_id);
        
        trial_folder_path = [subject_folder_path '\' subject_folder(trial_id).name];
        trial_folder = dir(trial_folder_path);
        trial_folder = trial_folder(3:end);
        
        %accessing the sweeps of each subject
        for sweep_id = 1: length(trial_folder)
            display(sweep_id);
            
            sweep_folder_path = [trial_folder_path '\' trial_folder(sweep_id).name];
            
            %accessing the containing folders of frames
            rgb_files_path = [sweep_folder_path '\RGB\'];
            rgb_files  = dir([rgb_files_path '*.jpg']);
            
            depth_files_path = [sweep_folder_path '\D\'];
            depth_files  = dir([depth_files_path '*.png']);
            
            thermal_files_path = [sweep_folder_path '\T\'];
            thermal_files  = dir([thermal_files_path '*.png']);
            
            %Reading each frame in all three modalities with syncd fps
            for rgbD_file_index = 1: length(rgb_files)
                
                %synchronized frames rates for all modalities (of RGBDT)
                if rgbD_file_index == 1
                    thermal_frame_index = 1;
                    rgb_frame = imread([rgb_files_path '\' rgb_files(rgbD_file_index).name]);
                    depth_frame = imread([depth_files_path '\' depth_files(rgbD_file_index).name]);
                    thermal_frame = imread([thermal_files_path '\' thermal_files(round(thermal_frame_index)).name]);
                else
                    
                    rgb_frame = imread([rgb_files_path '\' rgb_files(rgbD_file_index).name]);
                    depth_frame = imread([depth_files_path '\' depth_files(rgbD_file_index).name]);
                    
                    %calculating thermal frame index and reading the frame
                    thermal_Fs = 30;
                    previous_frame_time = str2double(rgb_files(rgbD_file_index-1).name(11:12)) + ...
                        str2double(rgb_files(rgbD_file_index-1).name(14:17))/10000.0;
                    current_frame_time = str2double(rgb_files(rgbD_file_index).name(11:12)) + ...
                        str2double(rgb_files(rgbD_file_index).name(14:17))/10000.0;
                    if((current_frame_time-previous_frame_time)>0)
                        rgbD_Fs = 1.0/(current_frame_time-previous_frame_time);
                    else
                        rgbD_Fs = 1.0/((60-previous_frame_time)+current_frame_time);
                    end
                    thermal_frame_index = thermal_frame_index+(thermal_Fs/rgbD_Fs);
                    if(round(thermal_frame_index)>length(thermal_files))
                        thermal_frame = imread([thermal_files_path '\' thermal_files(length(thermal_files)).name]);
                    else
                        thermal_frame = imread([thermal_files_path '\' thermal_files(round(thermal_frame_index)).name]);
                    end
                    
                end
                
                thermal_frame = flipdim(thermal_frame, 2);
                
                
                %calculating homographic points for pixel synchronization
                load('chessboardpoints.mat'); %eight points from the chess board in 2x8 or 3x8 format for xyz
                th_points = th_points(1:2, :); %keeping xy values in 2d image
                depth_points = depth_points(1:2, :); %keeping xy values in 2d image
                rgb_points_th = rgb_points_th(1:2, :); %keeping xy value in 2d image
                rgb_points_depth = rgb_points_depth(1:2, :); %keeping xy value in 2d image
                
                %calculating thermal homography
                rgb_points_th_H = cat(1, rgb_points_th, ones(1, 8)); %assuming z value as 1
                th_points_H = cat(1, th_points, ones(1, 8)); %assuming z value as 1
                th_homography = homography2d(rgb_points_th_H, th_points_H);
                
                %calculating depth homography
                rgb_points_depth_H = cat(1, rgb_points_depth, ones(1, 8)); %assuming z value as 1
                depth_points_H = cat(1, depth_points, ones(1, 8)); %assuming z value as 1
                depth_homography = homography2d(rgb_points_depth_H, depth_points_H);
                
                %face detection in the rgb frame
                faceDetector = vision.CascadeObjectDetector();
                rgb_bbox = step(faceDetector, rgb_frame);
                
                %finding rgb face bounding box points
                rgb_bbox_points = [cat(1, rgb_bbox(1), rgb_bbox(2)) cat(1, rgb_bbox(1)+rgb_bbox(3), rgb_bbox(2)+rgb_bbox(4))];
                rgb_bbox_points = cat(1, rgb_bbox_points, ones(1, 2));
                
                %finding thermal face bounding box points 
                th_bbox_points = th_homography*rgb_bbox_points;
                th_bbox_points = th_bbox_points(1:2, :)./cat(1, th_bbox_points(3, :), th_bbox_points(3, :));
                th_bbox = [th_bbox_points(1, 1) th_bbox_points(2, 1) abs(th_bbox_points(1,1)-th_bbox_points(1,2)) abs(th_bbox_points(2,1)-th_bbox_points(2,2))];
                
                %finding depth face bounding box points
                depth_bbox_points = depth_homography*rgb_bbox_points;
                depth_bbox_points = depth_bbox_points(1:2, :)./cat(1, depth_bbox_points(3, :), depth_bbox_points(3, :));
                depth_bbox = [depth_bbox_points(1, 1) depth_bbox_points(2, 1) abs(depth_bbox_points(1,1)-depth_bbox_points(1,2)) abs(depth_bbox_points(2,1)-depth_bbox_points(2,2))];
                
                
                %displaying in image figures
                videoOut = insertObjectAnnotation(rgb_frame,'rectangle',rgb_bbox,'Face');
                figure, imshow(videoOut), title('Detected face');
                videoOut = insertObjectAnnotation(thermal_frame,'rectangle',th_bbox,'Face');
                figure, imshow(videoOut), title('Detected face');
                videoOut = insertObjectAnnotation(histeq(depth_frame),'rectangle',depth_bbox,'Face');
                figure, imshow(videoOut), title('Detected face');
                
                
            end
            
        end
        
    end
    
end

fclose('all');
display('Completed operation');
