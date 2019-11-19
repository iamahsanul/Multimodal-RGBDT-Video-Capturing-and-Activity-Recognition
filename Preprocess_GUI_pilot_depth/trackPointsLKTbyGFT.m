function [ xLocPointTraces, yLocPointTraces, pointTraces ] = trackPointsLKTbyGFT( data_path, data_files, roi_coords )
%TRACKPOINTSLKTBYGFT takes video sequence path, reads frame and track roi
%   employing KLT tracker on GFT on the roi region only

first_frame = imread([data_path '\' data_files(1).name]); % first frame
%gray_frame = rgb2gray(first_frame); %not necessary when the frame is already gray 
gray_frame = first_frame;

% Detect feature points in the roi region without grids
% points = detectMinEigenFeatures(gray_frame, 'ROI', roi_coords);
% pointsLocs = points.Location;

% Detect feature points in the roi region by dividing it into grids
xmin = roi_coords(1); ymin = roi_coords(2);
xmax = xmin + roi_coords(3); ymax = ymin + roi_coords(4);

if xmax > size(first_frame, 1)  xmax = size(first_frame, 1); end
if ymax > size(first_frame, 2)  ymax = size(first_frame, 2); end

xStepMax = 25; yStepMax = 25; %grid size
pointsPerSubRegion = 10;
minDistanceBetweenPoints = 5;

startX = xmin; startY = ymin;
pointsLocs = [];
for startX = xmin : xStepMax : xmax-1
    xStep = min(xStepMax,xmax-startX);
    
    for startY =ymin : yStepMax : ymax-1
        yStep = min(yStepMax,ymax-startY);
        grid_coords = [startX startY xStep yStep];
        subpoints = detectMinEigenFeatures(gray_frame, 'ROI', grid_coords);
        subpointsLocs = subpoints.Location;
        pointsLocs = cat(1, pointsLocs, subpointsLocs);
    end
    
end

% % Display the detected points.
% figure, imshow(first_frame), hold on, title('Detected features');
% rectangle('Position',roi_coords, 'LineWidth',2, 'EdgeColor', 'r');
% plot(subpoints);

% Create a point tracker and enable the bidirectional error constraint to
% make it more robust in the presence of noise and clutter.
pointTracker = vision.PointTracker('MaxBidirectionalError', 2);

% Initialize the tracker with the initial point locations and the initial
% video frame.
initialize(pointTracker, pointsLocs, gray_frame);


videoPlayer  = vision.VideoPlayer('Position',...
    [100 100 [size(first_frame, 2), size(first_frame, 1)]+30]);


% Make a copy of the points to be used for computing the geometric
% transformation between the points in the previous and the current frames
oldPoints = pointsLocs;
visiblePoints = pointsLocs;
oldInliers = pointsLocs;

pointTraces = [];
prevPoints = pointsLocs;

for frameidx = 1 : length(data_files)
    currentFrame = imread([data_path '\' data_files(frameidx).name]);
    
    % Track the points. Note that some points may be lost.
%    [points, isFound] = step(pointTracker, rgb2gray(currentFrame)); % not necessary when the frame is already gray
    [points, isFound] = step(pointTracker, currentFrame);
    visiblePoints(isFound, :) = points(isFound, :);
    oldInliers(isFound, :) = oldPoints(isFound, :);
    
    if size(visiblePoints, 1) >= 2 % need at least 2 points
        
        % Estimate the geometric transformation between the old points
        % and the new points and eliminate outliers
        [xform, oldInliersGT, visiblePointsGT, status] = estimateGeometricTransform(...
            oldInliers, visiblePoints, 'similarity', 'MaxDistance', 4);
        
        % Display tracked points
        currentFrame = insertMarker(currentFrame, visiblePointsGT, '+', ...
            'Color', 'white');
        
        % Reset the points
        oldPoints = visiblePoints;
        %default matlab code to discard missing points.
        %        setPoints(pointTracker, oldPoints);
    end
    
    % Display the annotated video frame using the video player object
    step(videoPlayer, currentFrame);
    
    %saving the point traces in each frame
    prevPoints(isFound, :) = points(isFound, :);
    pointTraces = cat(3, pointTraces, prevPoints);
    
end

% Clean up
release(videoPlayer);
release(pointTracker);

xLocPointTraces = double(squeeze(pointTraces(:, 1, :)));
yLocPointTraces = double(squeeze(pointTraces(:, 2, :)));



end

