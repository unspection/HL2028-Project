clear; clc; close all;

%Load signals
edfFilename = 'R1.edf'; [~, record1] = edfread(edfFilename);
edfFilename = 'R2.edf'; [~, record2] = edfread(edfFilename);
edfFilename = 'R3.edf'; [~, record3] = edfread(edfFilename);
edfFilename = 'R4.edf'; [~, record4] = edfread(edfFilename);
edfFilename = 'R5.edf'; [~, record5] = edfread(edfFilename);
edfFilename = 'R6.edf'; [~, record6] = edfread(edfFilename);
edfFilename = 'R7.edf'; [~, record7] = edfread(edfFilename);
edfFilename = 'R8.edf'; [~, record8] = edfread(edfFilename);
edfFilename = 'R9.edf'; [~, record9] = edfread(edfFilename);
edfFilename = 'R10.edf'; [~, record10] = edfread(edfFilename);

EEG = record1(8, 1:length(record1));
EEG2 = record2(8, 1:length(record2));
EEG3 = record3(8, 1:length(record3));
EEG4 = record4(8, 1:length(record4));
EEG5 = record5(8, 1:length(record5));
EEG6 = record6(8, 1:length(record6));
EEG7 = record7(8, 1:length(record7));
EEG8 = record8(8, 1:length(record8));
EEG9 = record9(8, 1:length(record9));
EEG10 = record10(8, 1:length(record10));

%% Pre-rpocessing
filtered_EEG1 = preprocess_EEG(EEG);
filtered_EEG2 = preprocess_EEG(EEG2);
filtered_EEG3 = preprocess_EEG(EEG3);
filtered_EEG4 = preprocess_EEG(EEG4);
filtered_EEG5 = preprocess_EEG(EEG5);
filtered_EEG6 = preprocess_EEG(EEG6);
filtered_EEG7 = preprocess_EEG(EEG7);
filtered_EEG8 = preprocess_EEG(EEG8);
filtered_EEG9 = preprocess_EEG(EEG9);
filtered_EEG10 = preprocess_EEG(EEG10);

%% ---- DISCRETE WAVELET TRANSFORM --------
%(5 level wavelet db2)
[Alpha1, Beta1, Theta1, Delta1, Gamma1] =  waveletTransform(filtered_EEG1);
[Alpha2, Beta2, Theta2, Delta2, Gamma2] =  waveletTransform(filtered_EEG2);
[Alpha3, Beta3, Theta3, Delta3, Gamma3] =  waveletTransform(filtered_EEG3);
[Alpha4, Beta4, Theta4, Delta4, Gamma4] =  waveletTransform(filtered_EEG4);
[Alpha5, Beta5, Theta5, Delta5, Gamma5] =  waveletTransform(filtered_EEG5);
[Alpha6, Beta6, Theta6, Delta6, Gamma6] =  waveletTransform(filtered_EEG6);
[Alpha7, Beta7, Theta7, Delta7, Gamma7] =  waveletTransform(filtered_EEG7);
[Alpha8, Beta8, Theta8, Delta8, Gamma8] =  waveletTransform(filtered_EEG8);
[Alpha9, Beta9, Theta9, Delta9, Gamma9] =  waveletTransform(filtered_EEG9);
[Alpha10, Beta10, Theta10, Delta10, Gamma10] =  waveletTransform(filtered_EEG10);

%% Arrange dimensions for signals and features
[R1_Epoch, Alpha1, Beta1, Theta1, Delta1, Gamma1] = arrangeDataEEG(filtered_EEG1, Alpha1, Beta1, Theta1, Delta1, Gamma1);
[R2_Epoch, Alpha2, Beta2, Theta2, Delta2, Gamma2] = arrangeDataEEG(filtered_EEG2, Alpha2, Beta2, Theta2, Delta2, Gamma2);
[R3_Epoch, Alpha3, Beta3, Theta3, Delta3, Gamma3] = arrangeDataEEG(filtered_EEG3, Alpha3, Beta3, Theta3, Delta3, Gamma3);
[R4_Epoch, Alpha4, Beta4, Theta4, Delta4, Gamma4] = arrangeDataEEG(filtered_EEG4, Alpha4, Beta4, Theta4, Delta4, Gamma4);
[R5_Epoch, Alpha5, Beta5, Theta5, Delta5, Gamma5] = arrangeDataEEG(filtered_EEG5, Alpha5, Beta5, Theta5, Delta5, Gamma5);
[R6_Epoch, Alpha6, Beta6, Theta6, Delta6, Gamma6] = arrangeDataEEG(filtered_EEG6, Alpha6, Beta6, Theta6, Delta6, Gamma6);
[R7_Epoch, Alpha7, Beta7, Theta7, Delta7, Gamma7] = arrangeDataEEG(filtered_EEG7, Alpha7, Beta7, Theta7, Delta7, Gamma7);
[R8_Epoch, Alpha8, Beta8, Theta8, Delta8, Gamma8] = arrangeDataEEG(filtered_EEG8, Alpha8, Beta8, Theta8, Delta8, Gamma8);
[R9_Epoch, Alpha9, Beta9, Theta9, Delta9, Gamma9] = arrangeDataEEG(filtered_EEG9, Alpha9, Beta9, Theta9, Delta9, Gamma9);
[R10_Epoch, Alpha10, Beta10, Theta10, Delta10, Gamma10] = arrangeDataEEG(filtered_EEG10, Alpha10, Beta10, Theta10, Delta10, Gamma10);

nSamples = [height(R1_Epoch);height(R2_Epoch);height(R3_Epoch);...
    height(R4_Epoch);height(R5_Epoch);height(R6_Epoch);...
    height(R7_Epoch);height(R8_Epoch);height(R9_Epoch);height(R10_Epoch)];

%% Extract features
NEWfeatures1 = extractFeaturesEEG(R1_Epoch, Alpha1, Beta1, Theta1, Delta1, Gamma1);
NEWfeatures2 = extractFeaturesEEG(R2_Epoch, Alpha2, Beta2, Theta2, Delta2, Gamma2);
NEWfeatures3 = extractFeaturesEEG(R3_Epoch, Alpha3, Beta3, Theta3, Delta3, Gamma3);
NEWfeatures4 = extractFeaturesEEG(R4_Epoch, Alpha4, Beta4, Theta4, Delta4, Gamma4);
NEWfeatures5 = extractFeaturesEEG(R5_Epoch, Alpha5, Beta5, Theta5, Delta5, Gamma5);
NEWfeatures6 = extractFeaturesEEG(R6_Epoch, Alpha6, Beta6, Theta6, Delta6, Gamma6);
NEWfeatures7 = extractFeaturesEEG(R7_Epoch, Alpha7, Beta7, Theta7, Delta7, Gamma7);
NEWfeatures8 = extractFeaturesEEG(R8_Epoch, Alpha8, Beta8, Theta8, Delta8, Gamma8);
NEWfeatures9 = extractFeaturesEEG(R9_Epoch, Alpha9, Beta9, Theta9, Delta9, Gamma9);
NEWfeatures10 = extractFeaturesEEG(R10_Epoch, Alpha10, Beta10, Theta10, Delta10, Gamma10);

NEWfeatures = [NEWfeatures1;NEWfeatures2;NEWfeatures3;NEWfeatures4;NEWfeatures5;NEWfeatures6;NEWfeatures7;NEWfeatures8;NEWfeatures9;NEWfeatures10]; %feature matrix
NEWfeatures_norm = normalize(NEWfeatures); %normalize features

%% Save features as mat files
% save('NormFeaturesEEG.mat', 'NEWfeatures_norm');
% save('FeaturesEEG.mat', 'NEWfeatures');
% 
% %% Save features as xlsx files
% saveFeaturesEEG(NEWfeatures_norm, 'NormFeaturesEEG.xlsx');
% saveFeaturesEEG(NEWfeatures, 'FeaturesEEG.xlsx');

%% Load features
normFeatures = load('new_NormFeaturesEEG.mat');
fieldName = fieldnames(normFeatures);
normFeatures = normFeatures.(fieldName{1});

% Features = load('FeaturesEEG.mat');
% fieldName = fieldnames(Features);
% Features = Features.(fieldName{1});

%% Load and arrange stages
[~, stages_R1, ~, ~] = readXML('R1.xml');
[~, stages_R2, ~, ~] = readXML('R2.xml');
[~, stages_R3, ~, ~] = readXML('R3.xml');
[~, stages_R4, ~, ~] = readXML('R4.xml');
[~, stages_R5, ~, ~] = readXML('R5.xml');
[~, stages_R6, ~, ~] = readXML('R6.xml');
[~, stages_R7, ~, ~] = readXML('R7.xml');
[~, stages_R8, ~, ~] = readXML('R8.xml');
[~, stages_R9, ~, ~] = readXML('R9.xml');
[~, stages_R10, ~, ~] = readXML('R10.xml');

stages_R1 = reshape(stages_R1, 30, []);stages_R1 = stages_R1';
stages_R2 = reshape(stages_R2, 30, []);stages_R2 = stages_R2';
stages_R3 = reshape(stages_R3, 30, []);stages_R3 = stages_R3';
stages_R4 = reshape(stages_R4, 30, []);stages_R4 = stages_R4';
stages_R5 = reshape(stages_R5, 30, []);stages_R5 = stages_R5';
stages_R6 = reshape(stages_R6, 30, []);stages_R6 = stages_R6';
stages_R7 = reshape(stages_R7, 30, []);stages_R7 = stages_R7';
stages_R8 = reshape(stages_R8, 30, []);stages_R8 = stages_R8';
stages_R9 = reshape(stages_R9, 30, []);stages_R9 = stages_R9';
stages_R10 = reshape(stages_R10, 30, []);stages_R10 = stages_R10';

stages = [stages_R1; stages_R2; stages_R3; stages_R4; stages_R5;...
    stages_R6; stages_R7; stages_R8; stages_R9; stages_R10];

%% Approach 1: Create SVM model (one for each record)
[knownStages1, predictedStages1, testingData] = SVMmodelEEG(normFeatures,...
    stages, nSamples, 'polynomial', 'FINAL_SVM_result_EEG.xlsx');

%% Approach 2: Create SVM model 
[knownStages2, predictedStages2] = new_SVMmodelEEG(normFeatures,...
    stages, 'polynomial', 'FINAL_generic_SVM_result_EEG.xlsx');

%% Calculate confusion matrix for approach 1
%Get predictions for each recording
R1_prediction = predictedStages1(1:length(nonzeros(testingData(:,1))), 1); 
R2_prediction = predictedStages1(1:length(nonzeros(testingData(:,2))), 2); 
R3_prediction = predictedStages1(1:length(nonzeros(testingData(:,3))), 3); 
R4_prediction = predictedStages1(1:length(nonzeros(testingData(:,4))), 4);
R5_prediction = predictedStages1(1:length(nonzeros(testingData(:,5))), 5);
R6_prediction = predictedStages1(1:length(nonzeros(testingData(:,6))), 6); 
R7_prediction = predictedStages1(1:length(nonzeros(testingData(:,7))), 7); 
R8_prediction = predictedStages1(1:length(nonzeros(testingData(:,8))), 8); 
R9_prediction = predictedStages1(1:length(nonzeros(testingData(:,9))), 9);
R10_prediction = predictedStages1(1:length(nonzeros(testingData(:,10))), 10);

confusionMatrix(knownStages1, 1, R1_prediction)
confusionMatrix(knownStages1, 2, R2_prediction)
confusionMatrix(knownStages1, 3, R3_prediction)
confusionMatrix(knownStages1, 4, R4_prediction)
confusionMatrix(knownStages1, 5, R5_prediction)
confusionMatrix(knownStages1, 6, R6_prediction)
confusionMatrix(knownStages1, 7, R7_prediction)
confusionMatrix(knownStages1, 8, R8_prediction)
confusionMatrix(knownStages1, 9, R9_prediction)
confusionMatrix(knownStages1, 10, R10_prediction)

%% Calculate confusion matrix for approach 2
new_confusionMatrix(knownStages2, predictedStages2)

%% Plot for presentation
figure(2)
p1 = plot(EEG(1:1000));
hold on;
p2 = plot(filtered_EEG1(1:1000));
xlabel('Time');
legend([p1 p2],{'EEG raw signal','Preprocessed EEG'});