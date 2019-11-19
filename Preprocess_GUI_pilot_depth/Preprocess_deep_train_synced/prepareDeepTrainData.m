%data root setting
data_folder_path  = 'D:\RGBDT Pain Detection\RGBDT Database\Annotated_data\';
data_folders  = dir(data_folder_path);
data_folders = data_folders(3:end-6);
linux_data_root = '/home/admt/DeepLearnDock/LSTM-on-CNN-PainCVPR2017/MAH-VAP-PainData/Pain_Annotated_data/';

%train and validation file definitions
train_rgb = fopen([data_folder_path 'train_rgb.txt'],'w');
train_depth = fopen([data_folder_path 'train_depth.txt'],'w');
train_thermal = fopen([data_folder_path 'train_thermal.txt'],'w');
val_rgb = fopen([data_folder_path 'val_rgb.txt'],'w');
val_depth = fopen([data_folder_path 'val_depth.txt'],'w');
val_thermal = fopen([data_folder_path 'val_thermal.txt'],'w');

%video file count id
train_video_count = 1;
val_video_count = 1;


for sub_id = 1:length(data_folders)
    display(sub_id);
    
    subject_folder_path = [data_folder_path data_folders(sub_id).name];
    subject_folder = dir(subject_folder_path);
    subject_folder = subject_folder(3:end);
    
    for trial_id = 1: length(subject_folder)
        
        trial_folder_path = [subject_folder_path '\' subject_folder(trial_id).name];
        trial_folder = dir(trial_folder_path);
        trial_folder = trial_folder(3:end);
        
        for sweep_id = 1: length(trial_folder)
            
            sweep_folder_path = [trial_folder_path '\' trial_folder(sweep_id).name];
            linux_sweep_folder_path = [linux_data_root data_folders(sub_id).name '/' ...
                subject_folder(trial_id).name '/' trial_folder(sweep_id).name];
            
            rgb_files_path = [sweep_folder_path '\RGB\'];
            rgb_files  = dir([rgb_files_path '*.jpg']);
            
            
            depth_files_path = [sweep_folder_path '\D\'];
            depth_files  = dir([depth_files_path '*.png']);
            
            
            thermal_files_path = [sweep_folder_path '\T\'];
            thermal_files  = dir([thermal_files_path '*.png']);
            
            
            
            
            if(sweep_id<=72)        %listing in train file
                
                for rgb_file_index = 1: length(rgb_files)
                    fprintf(train_rgb, '%s\n', [linux_sweep_folder_path '/RGB/' rgb_files(rgb_file_index).name ...
                        ' ' trial_folder(sweep_id).name(end) ' ' num2str(train_video_count)]);
                end
                
                for depth_file_index = 1: length(depth_files)
                    fprintf(train_depth, '%s\n', [linux_sweep_folder_path '/D/' depth_files(depth_file_index).name ...
                        ' ' trial_folder(sweep_id).name(end) ' ' num2str(train_video_count)]);
                end
                
                for thermal_file_index = 1: length(thermal_files)
                    fprintf(train_thermal, '%s\n', [linux_sweep_folder_path '/T/' thermal_files(thermal_file_index).name ...
                        ' ' trial_folder(sweep_id).name(end) ' ' num2str(train_video_count)]);
                end
                
                train_video_count = train_video_count+1;
                
                
            else         %listing in validation file
                
                for rgb_file_index = 1: length(rgb_files)
                    fprintf(val_rgb, '%s\n', [linux_sweep_folder_path '/RGB/' rgb_files(rgb_file_index).name ...
                        ' ' trial_folder(sweep_id).name(end) ' ' num2str(val_video_count)]);
                end
                
                for depth_file_index = 1: length(depth_files)
                    fprintf(val_depth, '%s\n', [linux_sweep_folder_path '/D/' depth_files(depth_file_index).name ...
                        ' ' trial_folder(sweep_id).name(end) ' ' num2str(val_video_count)]);
                end
                
                for thermal_file_index = 1: length(thermal_files)
                    fprintf(val_thermal, '%s\n', [linux_sweep_folder_path '/T/' thermal_files(thermal_file_index).name ...
                        ' ' trial_folder(sweep_id).name(end) ' ' num2str(val_video_count)]);
                end
                
                val_video_count = val_video_count+1;
                
            end
            
            
            
            
        end
        
        
        
    end
    
    
end

fclose(train_rgb);
fclose(train_depth);
fclose(train_thermal);
fclose(val_rgb);
fclose(val_depth);
fclose(val_thermal);
fclose('all');

display('Complete train and validation file generation');
