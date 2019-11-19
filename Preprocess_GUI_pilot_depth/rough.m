%Depth
%for all motion classess
% load('feature_manual_cropped_gridPCA10_all.mat');
% load('feature_manual_cropped_gridResize_all.mat');
% load('feature_manual_cropped_radon_all.mat');
load('feature_manual_cropped_radonP2P_all');
[confusionMat, accuracy, classifiers] = classificationFramework(all_event_features, all_class_labels, all_class_size);

%for 4 motion classes
load('feature_manual_cropped_gridPCA10_all.mat');
load('feature_manual_cropped_gridResize_all.mat');
load('feature_manual_cropped_radon_all.mat');
load('feature_manual_cropped_radonP2P_all');
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
[confusionMat, accuracy, classifiers] = classificationFramework(all_event_features, all_class_labels, all_class_size);


save('sub1_night_session001.mat', 'axis_rgb_movement', ...
    'axis_thermal_movement', 'kinect_rgb_movement', ...
    'kinect_depth_movement', 'axis_thermal_movement_body');

figure; plot(axis_thermal_movement_body);
title('Axis Thermal Movement Body (Sub1 Night Session001)');
xlabel('Frame');
ylabel('Amplitude');

figure; plot(axis_thermal_movement);
title('Axis Thermal Movement (Sub1 Night Session001)');
xlabel('Frame');
ylabel('Amplitude');

figure; plot(axis_rgb_movement);
title('Axis RGB Movement (Sub1 Night Session001)');
xlabel('Frame');
ylabel('Amplitude');

figure; plot(kinect_rgb_movement);
title('Kinect RGB Movement (Sub1 Night Session001)');
xlabel('Frame');
ylabel('Amplitude');

figure; plot(kinect_depth_movement);
title('Kinect Depth Movement(Sub1 Night Session001)');
xlabel('Frame');
ylabel('Amplitude');

figure; plot(axis_thermal_movement_body); hold on;
plot(axis_thermal_movement);
plot(axis_rgb_movement);
plot(kinect_rgb_movement);
plot(kinect_depth_movement);

%Convert RGB 2 HSV Color conversion
[img_back_hsv]=round(rgb2hsv(img_back));
[img_fore_hsv]=round(rgb2hsv(img_fore));
output = bitxor(img_back_hsv,img_fore_hsv);

%Convert RGB 2 GRAY
output=rgb2gray(output);

%Convert to Binary Image
binary_mask = imbinarize(output, 0.1);

figure; 
subplot(2,2,1); imshow(binary_diff);
subplot(2,2,2); imshow(binary_fore);
subplot(2,2,3); imshow(img_diff);
subplot(2,2,4); imshow(img_fore);

detector = vision.ForegroundDetector('NumGaussians', 100, ...
            'NumTrainingFrames', 1, 'MinimumBackgroundRatio', 0.9);

blobAnalyser = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
            'AreaOutputPort', true, 'CentroidOutputPort', true, ...
            'MinimumBlobArea', 400);
        % Detect foreground.
        output = detector.step(img_fore);
figure; imshow(output)
        % Apply morphological operations to remove noise and fill in holes.
        output = imopen(output, strel('rectangle', [3,3]));
        output = imclose(output, strel('rectangle', [15, 15]));
        output = imfill(output, 'holes');

        % Perform blob analysis to find connected components.
        [~, centroids, bboxes] = blobAnalyser.step(output);
    img_fore = insertObjectAnnotation(img_fore,'rectangle',bboxes,scores);
figure
imshow(img_fore)
    

        
        

path = 'D:\Hammel Research\Hammel Implementation\Data\sub1_night_exp_data\';
rgb_files  = dir([path 'kinect_rgb\*.jpg']);
img_fore = imread([path 'kinect_rgb\' rgb_files(1).name]);


detector = peopleDetectorACF;
[bboxes,scores] = detect(detector,img_fore);
img_fore = insertObjectAnnotation(img_fore,'rectangle',bboxes,scores);
figure
imshow(img_fore)
title('Detected People and Detection Scores')



% Load frames
path = 'D:\Hammel Research\Hammel Implementation\Data\sub1_night_exp_data\';
rgb_files  = dir([path 'kinect_rgb\*.jpg']);
depth_files  = dir([path 'kinect_depth\*.png']);

depth_file_index = 1;
rgb_file_index = 1;

flip = 0;

for file_index = 1:length(rgb_files)
    display(file_index);
    
    if ~strcmp(rgb_files(rgb_file_index).name(5:17), depth_files(depth_file_index).name(3:15))
        disp(rgb_files(rgb_file_index+1).name(5:17));
        disp(depth_files(depth_file_index).name(3:15));
        rgb_file_index = rgb_file_index+1;
        
%         if flip == 0
%             rgb_file_index = rgb_file_index+1;
%             flip = 1;
%         else
%             depth_file_index = depth_file_index+1;
%             flip = 0;
%         end
        
        
    end
    depth_file_index = depth_file_index+1;
    rgb_file_index = rgb_file_index+1;


end


% open video file for frame extraction
  vid = VideoReader('D:\RGBDT Pain Detection\RGBDT Database\Sub1 Daniel Simonsen\kinect\pain1\My Movie2.mp4');
  Fs = round(vid.FrameRate);
  
