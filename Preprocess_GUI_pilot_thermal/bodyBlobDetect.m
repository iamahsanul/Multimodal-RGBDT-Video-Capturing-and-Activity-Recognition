function body_blob_bbox = bodyBlobDetect(img_fore) %returning bounding box of the bodyblob

%reading the reference background image
img_back = flipdim(imread('thermal_back.png'), 2);

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
%img_fore_bbox = insertObjectAnnotation(img_fore,'rectangle', body_blob_bbox, 1);

end