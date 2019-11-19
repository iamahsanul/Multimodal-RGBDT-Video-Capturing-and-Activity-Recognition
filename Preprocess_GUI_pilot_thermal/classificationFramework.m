function [finalConfusionMat, finalAccuracy, finalElapsedTime, finalClassifiers] = classificationFramework(raw_feature_data, raw_group_label, raw_group_size)
%%%%%%%%%%%
%Starting of the classificaiton framework
%feature_data is a m by n matrix where m is the number of events and n is the number of features for each event
%group_label is a m by 1 matrix containing the annotation of the events where m is the number of events 
%group_size is 1 by p matrix where p is the number of classess and each element of the matrix contains the number of events in the class
feature_data = raw_feature_data'; %transposition due to dimension adjustment
group_label = raw_group_label;
group_size = raw_group_size;

test_train_ratio=0.20; %percentage of testing data
disp(test_train_ratio);
select_classifier = 0; %all=0, and from the number below, eg. knn3=1, knn5=2, etc.

knn3_classify = 1;
knn5_classify = 2;
dt_classify = 3;
nb_classify = 4;
ann_classify = 5;
svmlinear_classify = 6;
svmpoly_classify = 7;
lda_classify = 8;
qda_classify = 9;
glm_classify = 10;
adaboost_classify = 11;
fcm_classify = 12;

finalConfusionMat=[]; %to return the results
finalAccuracy=[]; %to return the results
finalElapsedTime=[]; %to return the results
finalClassifiers={}; %to return the results

% Speed up Computations using Parallel Computing
% If Parallel Computing Toolbox is available, the computation will be
% distributed to 2 workers for speeding up the evaluation.
% if parpool('size') == 0
%     parpool open 4
% end


% Preparing the data for train-test partition
%Create dataset array
HaarData = cat(2, group_label, feature_data);

% Logical array keeping track of categorical attributes
[nrows, ncols] = size(HaarData);
category = false(1,ncols);
category(1) = true;
catPred = category(2:end);

% Set the random number seed to make the results repeatable in this script
rng('default');

% Response matrix with labels
Y = HaarData(:, 1); %class information
% tabulate(Y);

% Predictor matrix with features
X = HaarData(:,2:end); %feature data

%Divinding the data into train-test configuration
cv = cvpartition(size(HaarData, 1),'holdout', test_train_ratio);

% Training set
Xtrain = X(training(cv),:);
Ytrain = Y(training(cv),:);

% Test set
Xtest = X(test(cv),:);
Ytest = Y(test(cv),:);

% disp('Training Set');
% tabulate(Ytrain);
% disp('Test Set');
% tabulate(Ytest);

%Classifiers: 0=all, 1=KNN, 2=DT, 3=NB, 4=ANN, 5=SVM1, 6=SVM2, 7=FCM, 8=LDA, 9=GLM

if ((select_classifier==0)||(select_classifier==knn3_classify))
    % Classification Using Nearest Neighbors
    % Categorizing query points based on their distance to points in a training
    % dataset can be a simple yet effective way of classifying new points.
    % Various distance metrics such as euclidean, correlation, hamming,
    % mahalonobis or your own distance metric may be used.
    
    disp('KNN3');
    
    % Train the classifier
    t = cputime;
    tic;
    knn_template = templateKNN('NumNeighbors',3,'Standardize',1, 'Distance', 'correlation');
    knn = fitcecoc(Xtrain, Ytrain, 'Learners', knn_template);
    toc;
    
    % Make a prediction for the test set
    Y_knn = knn.predict(Xtest);
    
    % Compute the confusion matrix
    C_knn = confusionmat(Ytest,Y_knn);
    % Examine the confusion matrix for each class as a percentage of the true class
    C_knn_percent = bsxfun(@rdivide,C_knn,sum(C_knn,2)) * 100;
    C_knn_percent(isnan(C_knn_percent)) = 0;
    avg_C_knn=trace(C_knn_percent)/size(C_knn_percent,1);
    e = cputime;
    t_knn = e-t;
    
    %updating the returning result matrices
    finalConfusionMat=cat(3, finalConfusionMat, C_knn);
    finalAccuracy=cat(2, finalAccuracy, avg_C_knn);
    finalElapsedTime=cat(2, finalElapsedTime, t_knn);
    finalClassifiers=cat(2, finalClassifiers, {'KNN3'});
    
end

if ((select_classifier==0)||(select_classifier==knn5_classify))
    % Classification Using Nearest Neighbors
    % Categorizing query points based on their distance to points in a training
    % dataset can be a simple yet effective way of classifying new points.
    % Various distance metrics such as euclidean, correlation, hamming,
    % mahalonobis or your own distance metric may be used.
    
    disp('KNN5');
    
    % Train the classifier
    t = cputime;
    tic;
    knn_template = templateKNN('NumNeighbors',5,'Standardize',1, 'Distance', 'correlation');
    knn = fitcecoc(Xtrain, Ytrain, 'Learners', knn_template);
    toc;
    
    % Make a prediction for the test set
    Y_knn = knn.predict(Xtest);
    
    % Compute the confusion matrix
    C_knn = confusionmat(Ytest,Y_knn);
    % Examine the confusion matrix for each class as a percentage of the true class
    C_knn_percent = bsxfun(@rdivide,C_knn,sum(C_knn,2)) * 100;
    C_knn_percent(isnan(C_knn_percent)) = 0;
    avg_C_knn=trace(C_knn_percent)/size(C_knn_percent,1);
    e = cputime;
    t_knn = e-t;
    
    %updating the returning result matrices
    finalConfusionMat=cat(3, finalConfusionMat, C_knn);
    finalAccuracy=cat(2, finalAccuracy, avg_C_knn);
    finalElapsedTime=cat(2, finalElapsedTime, t_knn);
    finalClassifiers=cat(2, finalClassifiers, {'KNN5'});
    
end


if ((select_classifier==0)||(select_classifier==dt_classify))
    % Decision Trees
    % Classification trees and regression trees are two kinds of decision
    % trees. A decision tree is a flow-chart like structure in which internal
    % node represents test on an attribute, each branch represents outcome of
    % test and each leaf node represents a response (decision taken after
    % computing all attributes). Classification trees give responses that are
    % nominal, such as 'true' or 'false'. Regression trees give numeric
    % responses.
    
    disp('DT');
    
    % Train the classifier
    tdt = cputime;
    tic
    dt_template = templateTree('Surrogate','on', 'PredictorSelection','interaction-curvature');
    dt = fitcecoc(Xtrain, Ytrain, 'Learners', dt_template);
    toc
    
    % Make a prediction for the test set
    Y_dt = dt.predict(Xtest);
    
    % Compute the confusion matrix
    C_dt = confusionmat(Ytest,Y_dt);
    % Examine the confusion matrix for each class as a percentage of the true class
    C_dt_percent = bsxfun(@rdivide,C_dt,sum(C_dt,2)) * 100;
    C_dt_percent(isnan(C_dt_percent)) = 0;
    avg_C_dt=trace(C_dt_percent)/size(C_dt_percent,1);
    e = cputime;
    t_dt = e-tdt;
    
    %updating the returning result matrices
    finalConfusionMat=cat(3, finalConfusionMat, C_dt);
    finalAccuracy=cat(2, finalAccuracy, avg_C_dt);
    finalElapsedTime=cat(2, finalElapsedTime, t_dt);
    finalClassifiers=cat(2, finalClassifiers, {'DT'});
    
end


if ((select_classifier==0)||(select_classifier==nb_classify))
    % Naive Bayes Classification
    % Naive Bayes classification is based on estimating P(X|Y), the probability
    % or probability density of features X given class Y. The Naive Bayes
    % classification object provides support for normal (Gaussian), kernel,
    % multinomial, and multivariate multinomial distributions
    
    % The multivariate multinomial distribution (_mvmn_) is appropriate for
    % categorical features
    
    disp('NB');
    
    t = cputime;
    dist = repmat({'normal'},1,ncols-1);
    dist(catPred) = {'mvmn'};
    
    % Train the classifier
    tic;
    nb_template = templateNaiveBayes('DistributionNames', dist);
    Nb = fitcecoc(Xtrain, Ytrain, 'Learners', nb_template);
    toc;
    
    % Make a prediction for the test set
    Y_Nb = Nb.predict(Xtest);
    
    % Compute the confusion matrix
    C_nb = confusionmat(Ytest,Y_Nb);
    % Examine the confusion matrix for each class as a percentage of the true class
    C_nb_percent = bsxfun(@rdivide,C_nb,sum(C_nb,2)) * 100;
    C_nb_percent(isnan(C_nb_percent)) = 0;
    avg_C_nb=trace(C_nb_percent)/size(C_nb_percent,1);
    e = cputime;
    t_nb = e-t;
    
    %updating the returning result matrices
    finalConfusionMat=cat(3, finalConfusionMat, C_nb);
    finalAccuracy=cat(2, finalAccuracy, avg_C_nb);
    finalElapsedTime=cat(2, finalElapsedTime, t_nb);
    finalClassifiers=cat(2, finalClassifiers, {'NB'});
    
end
    

if ((select_classifier==0)||(select_classifier==ann_classify))
    %Artificial neural network (ANN)
    
    disp('ANN');
    
    t = cputime;
    %Neural Network
    tic;
    [XtrainNN, YtrainNN, XtestNN, YtestNN] = preparedataNN(HaarData, catPred, cv);
    
    % Use modified autogenerated code to train the network
    [~, net] = NNfun(XtrainNN,YtrainNN);
    toc;
    
    % Make a prediction for the test set
    Y_nn = net(XtestNN');
    Y_nn = round(Y_nn');
    
    % Compute the confusion matrix
    C_nn = confusionmat(YtestNN,Y_nn);
    % Examine the confusion matrix for each class as a percentage of the true class
    C_nn_percent = bsxfun(@rdivide,C_nn,sum(C_nn,2)) * 100; %#ok<*NOPTS>
    C_nn_percent(isnan(C_nn_percent)) = 0;
    avg_C_nn=trace(C_nn_percent)/size(C_nn_percent,1);
    e = cputime;
    t_nn=e-t;
    
    %updating the returning result matrices
    finalConfusionMat=cat(3, finalConfusionMat, C_nn);
    finalAccuracy=cat(2, finalAccuracy, avg_C_nn);
    finalElapsedTime=cat(2, finalElapsedTime, t_nn);
    finalClassifiers=cat(2, finalClassifiers, {'ANN'});
    
end


if ((select_classifier==0)||(select_classifier==svmlinear_classify))
    % Support Vector Machines: Multiclass SVM with Error-Correcting Output Codes (ECOC)
    % Support vector machine (SVM) is supported for binary response variables.
    % An SVM classifies data by finding the best hyperplane that separates all
    % data points of one class from those of the other class.
        
    disp('SVM-ECOC-Linear');

    % Train the classifier
    t = cputime;
    svm_template = templateSVM('KernelFunction','linear', 'KKTTolerance', 0.1, ...
        'IterationLimit', 5000);
    tic;
    svmStruct = fitcecoc(Xtrain, Ytrain, 'Learners', svm_template, 'Coding','onevsone');
    toc;
    
    % Make a prediction for the test set
    Y_svm = predict(svmStruct,Xtest);
    C_svm = confusionmat(Ytest,Y_svm);
    % Examine the confusion matrix for each class as a percentage of the true class
    C_svm_percent = bsxfun(@rdivide,C_svm,sum(C_svm,2)) * 100;
    C_svm_percent(isnan(C_svm_percent)) = 0;
    avg_C_svm=trace(C_svm_percent)/size(C_svm_percent,1);
    e = cputime;
    t_svm = e-t;
    
    %updating the returning result matrices
    finalConfusionMat=cat(3, finalConfusionMat, C_svm);
    finalAccuracy=cat(2, finalAccuracy, avg_C_svm);
    finalElapsedTime=cat(2, finalElapsedTime, t_svm);
    finalClassifiers=cat(2, finalClassifiers, {'SVM-ECOC-Linear'});
    
end
    
if ((select_classifier==0)||(select_classifier==svmpoly_classify))
    % Support Vector Machines: Multiclass SVM with Error-Correcting Output Codes (ECOC)
    % Support vector machine (SVM) is supported for binary response variables.
    % An SVM classifies data by finding the best hyperplane that separates all
    % data points of one class from those of the other class.
        
    disp('SVM-ECOC-Polynomial');

    % Train the classifier
    t = cputime;
    svm_template = templateSVM('KernelFunction','polynomial', 'KKTTolerance', 0.1, ...
        'IterationLimit', 5000, 'PolynomialOrder', 5);
    tic;
    svmStruct = fitcecoc(Xtrain, Ytrain, 'Learners', svm_template, 'Coding','onevsone');
    toc;
    
    % Make a prediction for the test set
    Y_svm = predict(svmStruct,Xtest);
    C_svm = confusionmat(Ytest,Y_svm);
    % Examine the confusion matrix for each class as a percentage of the true class
    C_svm_percent = bsxfun(@rdivide,C_svm,sum(C_svm,2)) * 100;
    C_svm_percent(isnan(C_svm_percent)) = 0;
    avg_C_svm=trace(C_svm_percent)/size(C_svm_percent,1);
    e = cputime;
    t_svm = e-t;
    
    %updating the returning result matrices
    finalConfusionMat=cat(3, finalConfusionMat, C_svm);
    finalAccuracy=cat(2, finalAccuracy, avg_C_svm);
    finalElapsedTime=cat(2, finalElapsedTime, t_svm);
    finalClassifiers=cat(2, finalClassifiers, {'SVM-ECOC-Polynomial'});
    
end
    
    
if ((select_classifier==0)||(select_classifier==fcm_classify))
    % Fuzzy C-Means algorithm
        
    disp('FCM');

%     tt = cputime;
%     tic
%     % Train the classifier
%     t = ClassificationTree.fit(Xtrain,Ytrain,'CategoricalPredictors',catPred);
%     toc
%     
%     % Make a prediction for the test set
%     Y_t = t.predict(Xtest);
%     
%     % Compute the confusion matrix
%     C_t = confusionmat(Ytest,Y_t);
%     % Examine the confusion matrix for each class as a percentage of the true class
%     C_t = bsxfun(@rdivide,C_t,sum(C_t,2)) * 100;
%     C_t_percent(isnan(C_t_percent)) = 0;
%     avg_C_t=trace(C_t)/size(C_t,1);
%     e = cputime;
%     t_t = e-tt;
%     
%     %updating the returning result matrices
%     finalConfusionMat=cat(3, finalConfusionMat, C_t);
%     finalAccuracy=cat(2, finalAccuracy, avg_C_t);
%     finalElapsedTime=cat(2, finalElapsedTime, t_t);
%     finalClassifiers=cat(2, finalClassifiers, {'DT'});
    
end


if ((select_classifier==0)||(select_classifier==lda_classify))
    % Linear Discriminant Analysis
    % Discriminant analysis is a classification method. It assumes that
    % different classes generate data based on different Gaussian
    % distributions. Linear discriminant analysis is also known as the Fisher
    % discriminant.
    %
    % Here, a quadratic discriminant classifier is used.
        
    disp('LDA');

    % Train the classifier
    t = cputime;
    lda_template = templateDiscriminant('DiscrimType','pseudolinear');
    tic;
    lda = fitcecoc(Xtrain, Ytrain, 'Learners', lda_template);
    toc;
    
    % Make a prediction for the test set
    Y_lda = lda.predict(Xtest);
    
    % Compute the confusion matrix
    C_lda = confusionmat(Ytest,Y_lda);
    C_lda(isnan(C_lda)) = 0;
    % Examine the confusion matrix for each class as a percentage of the true class
    C_lda_percent = bsxfun(@rdivide,C_lda,sum(C_lda,2)) * 100;
    C_lda_percent(isnan(C_lda_percent)) = 0;
    avg_C_lda=trace(C_lda_percent)/size(C_lda_percent,1);
    e = cputime;
    t_lda = e-t;
    
    %updating the returning result matrices
    finalConfusionMat=cat(3, finalConfusionMat, C_lda);
    finalAccuracy=cat(2, finalAccuracy, avg_C_lda);
    finalElapsedTime=cat(2, finalElapsedTime, t_lda);
    finalClassifiers=cat(2, finalClassifiers, {'LDA'});
    
end


if ((select_classifier==0)||(select_classifier==qda_classify))
    % Quadratic Discriminant Analysis
    % Discriminant analysis is a classification method. It assumes that
    % different classes generate data based on different Gaussian
    % distributions. Linear discriminant analysis is also known as the Fisher
    % discriminant.
    %
    % Here, a quadratic discriminant classifier is used.
        
    disp('QDA');

    % Train the classifier
    t = cputime;
    tic;
    qda_template = templateDiscriminant('DiscrimType','pseudoquadratic');
    qda = fitcecoc(Xtrain, Ytrain, 'Learners', qda_template);
    toc;
    
    % Make a prediction for the test set
    Y_qda = qda.predict(Xtest);
    
    % Compute the confusion matrix
    C_qda = confusionmat(Ytest,Y_qda);
    C_qda(isnan(C_qda)) = 0;
    % Examine the confusion matrix for each class as a percentage of the true class
    C_qda_percent = bsxfun(@rdivide,C_qda,sum(C_qda,2)) * 100;
    C_qda_percent(isnan(C_qda_percent)) = 0;
    avg_C_qda=trace(C_qda_percent)/size(C_qda_percent,1);
    e = cputime;
    t_qda = e-t;
    
    %updating the returning result matrices
    finalConfusionMat=cat(3, finalConfusionMat, C_qda);
    finalAccuracy=cat(2, finalAccuracy, avg_C_qda);
    finalElapsedTime=cat(2, finalElapsedTime, t_qda);
    finalClassifiers=cat(2, finalClassifiers, {'QDA'});
    
end


if ((select_classifier==0)||(select_classifier==glm_classify))
    % Generalized Linear Model - Logistic Regression
    % In this example, a logistic regression model is leveraged. Response may
    % follow normal, binomial, Poisson, gamma, or inverse Gaussian
    % distribution.
    %
    % Since the response in this data set is binary, binomial distribution is
    % suitable.
        
    disp('GLM');

    % Train the classifier
    t = cputime;
    tic;
    glm_template = templateLinear('Learner','logistic', 'Regularization','ridge', 'Solver',{'sgd','lbfgs'});
    glm = fitcecoc(Xtrain, Ytrain, 'Learners', glm_template);
    toc;
    
    % Make a prediction for the test set
    Y_glm = glm.predict(Xtest);
    Y_glm = round(Y_glm);% + 1;
    
    % Compute the confusion matrix
    C_glm = confusionmat(double(Ytest),Y_glm);
    % Examine the confusion matrix for each class as a percentage of the true class
    C_glm_percent = bsxfun(@rdivide,C_glm,sum(C_glm,2)) * 100;
    C_glm_percent(isnan(C_glm_percent)) = 0;
    avg_C_glm=trace(C_glm_percent)/size(C_glm_percent,1);
    e = cputime;
    t_glm=e-t;
    
    %updating the returning result matrices
    finalConfusionMat=cat(3, finalConfusionMat, C_glm);
    finalAccuracy=cat(2, finalAccuracy, avg_C_glm);
    finalElapsedTime=cat(2, finalElapsedTime, t_glm);
    finalClassifiers=cat(2, finalClassifiers, {'GLM'});
    
end

if ((select_classifier==0)||(select_classifier==adaboost_classify))
    % Adaboost classification - ensemble learning
        
    disp('AdaBoost');

    % Train the classifier
    t = cputime;
    tic;
    dt_template = templateTree('Surrogate','on', 'PredictorSelection','interaction-curvature');
    if (length(group_size)<3)
        adaboost_template = templateEnsemble('AdaBoostM1',1000, dt_template, 'LearnRate',0.1);
    else
        adaboost_template = templateEnsemble('AdaBoostM2',1000, dt_template, 'LearnRate',0.1);
    end
    adaboost = fitcecoc(Xtrain, Ytrain, 'Learners', adaboost_template);
    toc;
    
    % Make a prediction for the test set
    Y_adaboost = adaboost.predict(Xtest);
    Y_adaboost = round(Y_adaboost);% + 1;
    
    % Compute the confusion matrix
    C_adaboost = confusionmat(double(Ytest),Y_adaboost);
    % Examine the confusion matrix for each class as a percentage of the true class
    C_adaboost_percent = bsxfun(@rdivide,C_adaboost,sum(C_adaboost,2)) * 100;
    C_adaboost_percent(isnan(C_adaboost_percent)) = 0;
    avg_C_adaboost=trace(C_adaboost_percent)/size(C_adaboost_percent,1);
    e = cputime;
    t_adaboost=e-t;
    
    %updating the returning result matrices
    finalConfusionMat=cat(3, finalConfusionMat, C_adaboost);
    finalAccuracy=cat(2, finalAccuracy, avg_C_adaboost);
    finalElapsedTime=cat(2, finalElapsedTime, t_adaboost);
    finalClassifiers=cat(2, finalClassifiers, {'Adaboost'});
    
end


%Saving the result in excel file
% filename='rought_results.xlsx';
% header={};
% header{1}='ANN';
% header{2}='GLM';
% header{3}='LDA';
% header{4}='KNN';
% header{5}='NB';
% header{6}='SVM';
% header{7}='DT';
% header{8}='FCM';
% xlswrite(filename,[header; num2cell(finalData)]);

end

