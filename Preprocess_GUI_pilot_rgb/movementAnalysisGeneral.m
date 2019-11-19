function moving_frame = movementAnalysisGeneral()
path = '..\Data\blob_detection_data';

% directory setting for foreground and background thermal images
fore_files  = dir([path '\foreground\*.png']);
back_files  = dir([path '\background\*.png']);

for file_index = 1:length(fore_files)
    display(file_index);
img_back = flipdim(imread('thermal_back.png'), 2);

% img_fore = flipdim(imread('depth_fore.png'), 2);
img_fore = flipdim(imread([fore_files(1).folder '\' fore_files(file_index).name]), 2);


img_diff = abs(img_fore-img_back);

%Convert to Binary Image
binary_fore = im2bw(img_fore, 0.1);
binary_diff = im2bw(img_diff, 0.2);

%Apply Median filter to remove Noise
binary_fore_filtered = medfilt2(binary_fore,[20 20]);
binary_diff_filtered = medfilt2(binary_diff,[20 20]);

%Employing morphological operation to close and fill the blobs in bkground
binary_diff_filtered = imclose(binary_diff_filtered, strel('rectangle', [20, 20]));
binary_diff_filtered = imfill(binary_diff_filtered, 'holes');

%Employing morphological operation to close and fill the blobs in img frame
% binary_fore_filtered = imclose(binary_fore_filtered, strel('rectangle', [20, 20]));
binary_fore_filtered = imfill(binary_fore_filtered, 'holes');

%detecting blob in binarized filtered differential image
[L_diff, num_diff]=bwlabel(binary_diff_filtered);
stats_diff = regionprops(L_diff,'all');
%Remove the noisy regions and selecting the body/head blob
blob_area = []; %distance of body blobs to all blob centroids
for i=1:num_diff
    blob_area = cat(1, blob_area, stats_diff(i).Area); 
end
[~, maxBlob_index] = max(blob_area);
L_diff(L_diff~=maxBlob_index)=0; %removing all other blobs except body blob

%redetecting blobs after noisy blobs removal
[L_diff_final, num_diff_final]=bwlabel(L_diff);
stats_diff = regionprops(L_diff_final,'all');
diff_body_centroid=stats_diff.Centroid;

%detecting blob in binarized filtered original video frame
[L_img, num_img]=bwlabel(binary_fore_filtered);
stats_img = regionprops(L_img,'all');
%Remove the noisy regions and selecting the body/head blob
blob_c_dist = []; %distance of body blobs to all blob centroids
for i=1:num_img
    img_centroid=stats_img(i).Centroid;
    blob_c_dist = cat(1, blob_c_dist, pdist2(diff_body_centroid, img_centroid)); 
end
[~, body_blob_index] = min(blob_c_dist);
L_img(L_img~=body_blob_index)=0; %removing all other blobs except body blob

%annotating original image with body bounding box for depiction
body_blob_bbox = stats_img(body_blob_index).BoundingBox;
img_fore_bbox = insertObjectAnnotation(img_fore,'rectangle', body_blob_bbox, 1);

%Masking the origninal image by the deteceted final blob
%Augment the mask into three channels for masking color image
L_img_rgbMask = L_img;
L_img_rgbMask(:,:,2) = L_img_rgbMask;
L_img_rgbMask(:,:,3) = L_img_rgbMask(:,:,1);
%masking original image
L_img_rgbBlob = img_fore;
L_img_rgbBlob(L_img_rgbMask == 0) = 0;


%redetecting blobs after noisy blobs removal and
% Trace region boundaries in a binary image.
[B,L_img_final,N,A] = bwboundaries(L_img);

%Display results
subplot(2,2,1),  imshow(img_fore);title(['ForeGround: ' int2str(file_index)]);
subplot(2,2,2),  imshow(img_fore_bbox);title('ForeGround with bbox');
subplot(2,2,4),  imshow(L_img_rgbBlob);title('Blob in the image');
subplot(2,2,3),  imshow(L_img_final);title('Blob Detected');
hold on;

for k=1:length(B)
    if(~sum(A(k,:)))
        boundary = B{k};
        plot(boundary(:,2), boundary(:,1), 'r','LineWidth',2);
        for l=find(A(:,k))'
            boundary = B{l};
            plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
        end
    end
end
hold off;
pause(1);


end