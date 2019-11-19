# Multimodal-RGBDT-Video-Capturing-and-Activity-Recognition
A Matlab project for multimodal (color, depth and thermal) video data recording, annotation, and analysis using traditional machine learning methods. The code includes multi-camera calibration and synchronization, human body segmentation, feature point tracking in image sequences, time series analysis, application of multiple machine learning methods.


# Prerequisites
- Matlab 2017a

# What is accomplished
- Motion tracking using Lucas-Kennedy-Thomasi tracker with 'Good Features to Track' method. 
- Feature extraction by first difference of tracked points in video sequence, PCA, Radon transformation and point-to-point distance of Radon transformed image. 
- Classification using shallow learning methods such as KNN, DT, NB, SVM, LDA and GLM

# Content description
- Extracted_features: Contains all the extracted features from different modalities. The reference paper below utilized four different feature types from three different modalities. Please follow the feature matrix names in the folders according to the names used in the paper. 
- Preprocess_GUI_pilot_depth: Contains all the scripts necessary to extract the features from depth videos, feed the feautures into the classification frameworks and prepare the outcomes through a GUI interface. 
- Preprocess_GUI_pilot_rgb: Contains all the scripts necessary to extract the features from rgb videos, feed the feautures into the classification frameworks and prepare the outcomes through a GUI interface. 
- Preprocess_GUI_pilot_thermal: Contains all the scripts necessary to extract the features from thermal videos, feed the feautures into the classification frameworks and prepare the outcomes through a GUI interface. 
- Tracking example in videos: Contains one illustration of motion tracking for each of the class labels from thermal and rgb videos of subject. 

# How to run
- Feature extraction process needs the original video dataset which will available in the future. Therefore, feature extraction scripts are only relevant as reference. 
- Classification for each modalities by using each of the classifiers used in the reference paper below can be accessible by the GUI interface from the relevant folder. 

# Please note!
- Features obtained from point-to-point distance of Radon transformed image is not available in the Extracted_features folder. This is because of exceeding acceptable limit of the size of the feature file in git. You can get those features on request. 

# Please cite
Haque M.A. et al. (2018) Patient’s Body Motion Study Using Multimodal RGBDT Videos. In: Bebis G. et al. (eds) Advances in Visual Computing. ISVC 2018. Lecture Notes in Computer Science, vol 11241. Springer, Cham
