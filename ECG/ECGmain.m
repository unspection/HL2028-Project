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

%% Get segements of the signals (with cut)
ECG_R1 = record1(4, 1:3495000); ECG_R1 = ECG_R1';
ECG_R2 = record2(4, 1:1725000); ECG_R2 = ECG_R2';
ECG_R3 = record3(4, 1380001:length(record3)); ECG_R3 = ECG_R3';
ECG_R4 = record4(4, 1:length(record4)); ECG_R4 = ECG_R4';
ECG_R5 = record5(4, 1:length(record5)); ECG_R5 = ECG_R5';
ECG_R6 = record6(4, 1:length(record6)); ECG_R6 = ECG_R6';
ECG_R7 = record7(4, 1:length(record7)); ECG_R7 = ECG_R7';
ECG_R8 = record8(4, 1:length(record8)); ECG_R8 = ECG_R8';
ECG_R9 = record9(4, 1:3723750); ECG_R9 = ECG_R9';
ECG_R10 = record10(4, 1:length(record10)); ECG_R10 = ECG_R10';

%% Preprocessing
preprocessed_R1 = preprocess(ECG_R1);
preprocessed_R2 = preprocess(ECG_R2);
preprocessed_R3 = preprocess(ECG_R3);
preprocessed_R4 = preprocess(ECG_R4);
preprocessed_R5 = preprocess(ECG_R5);
preprocessed_R6 = preprocess(ECG_R6);
preprocessed_R7 = preprocess(ECG_R7);
preprocessed_R8 = preprocess(ECG_R8);
preprocessed_R9 = preprocess(ECG_R9);
preprocessed_R10 = preprocess(ECG_R10);

%% Arrange dataset 
epoch_R1 = arrangeDataECG(preprocessed_R1); 
epoch_R2 = arrangeDataECG(preprocessed_R2);
epoch_R3 = arrangeDataECG(preprocessed_R3);
epoch_R4 = arrangeDataECG(preprocessed_R4); epoch_R4(end,:) = [];
epoch_R5 = arrangeDataECG(preprocessed_R5); epoch_R5(end,:) = [];
epoch_R6 = arrangeDataECG(preprocessed_R6); epoch_R6(end,:) = [];
epoch_R7 = arrangeDataECG(preprocessed_R7); epoch_R7(end,:) = [];
epoch_R8 = arrangeDataECG(preprocessed_R8); epoch_R8(end,:) = [];
epoch_R9 = arrangeDataECG(preprocessed_R9);
epoch_R10 = arrangeDataECG(preprocessed_R10); epoch_R10(end,:) = [];

%Number of samples for each recording
nSamples = [height(epoch_R1);height(epoch_R2);height(epoch_R3);...
    height(epoch_R4);height(epoch_R5);height(epoch_R6);height(epoch_R7);...
    height(epoch_R8);height(epoch_R9);height(epoch_R10)]; 

%% Get RR intervals
RRInterval_R1 = findRRinterval(epoch_R1, height(epoch_R1));
RRInterval_R2 = findRRinterval(epoch_R2, height(epoch_R2));
RRInterval_R3 = findRRinterval(epoch_R3, height(epoch_R3));
RRInterval_R4 = findRRinterval(epoch_R4, height(epoch_R4));
RRInterval_R5 = findRRinterval(epoch_R5, height(epoch_R5));
RRInterval_R6 = findRRinterval(epoch_R6, height(epoch_R6));
RRInterval_R7 = findRRinterval(epoch_R7, height(epoch_R7));
RRInterval_R8 = findRRinterval(epoch_R8, height(epoch_R8));
RRInterval_R9 = findRRinterval(epoch_R9, height(epoch_R9));
RRInterval_R10 = findRRinterval(epoch_R10, height(epoch_R10));

%% Extract features
hrv_R1 = extractFeaturesECG(RRInterval_R1);
hrv_R2 = extractFeaturesECG(RRInterval_R2);
hrv_R3 = extractFeaturesECG(RRInterval_R3);
hrv_R4 = extractFeaturesECG(RRInterval_R4);
hrv_R5 = extractFeaturesECG(RRInterval_R5);
hrv_R6 = extractFeaturesECG(RRInterval_R6);
hrv_R7 = extractFeaturesECG(RRInterval_R7);
hrv_R8 = extractFeaturesECG(RRInterval_R8);
hrv_R9 = extractFeaturesECG(RRInterval_R9);
hrv_R10 = extractFeaturesECG(RRInterval_R10);

hrv = [hrv_R1;hrv_R2;hrv_R3;hrv_R4;hrv_R5;hrv_R6;hrv_R7;hrv_R8;...
    hrv_R9;hrv_R10]; 

%% Save features as xlsx file
% saveFeaturesECG(hrv, 'hrv_features.xlsx');

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

%%
stages_R1 = reshape(stages_R1, 30, []); stages_R1 = stages_R1';
stages_R1(length(hrv_R1)+1:end,:) = [];

stages_R2 = reshape(stages_R2, 30, []); stages_R2 = stages_R2';
stages_R2(length(hrv_R2)+1:end,:) = [];

stages_R3 = reshape(stages_R3, 30, []); stages_R3 = stages_R3';
stages_R3(1:length(stages_R3)-length(hrv_R3),:) = [];

stages_R4 = reshape(stages_R4, 30, []); stages_R4 = stages_R4';

stages_R5 = reshape(stages_R5, 30, []); stages_R5 = stages_R5';

stages_R6 = reshape(stages_R6, 30, []); stages_R6 = stages_R6';

stages_R7 = reshape(stages_R7, 30, []); stages_R7 = stages_R7';

stages_R8 = reshape(stages_R8, 30, []); stages_R8 = stages_R8';

stages_R9 = reshape(stages_R9, 30, []); stages_R9 = stages_R9';
stages_R9(length(hrv_R9)+1:end,:) = [];

stages_R10 = reshape(stages_R10, 30, []); stages_R10 = stages_R10';

stages = [stages_R1;stages_R2;stages_R3;stages_R4;stages_R5;...
    stages_R6;stages_R7;stages_R8;stages_R9;stages_R10];

%% Approach 1: Create SVM model (one for each record)
[knownStages1, predictedStages1, testingData] = SVMmodel(hrv,...
    stages, nSamples, 'linear', 'FINAL_SVM_result_ECG.xlsx');

%% Approach 2: Create SVM model 
[knownStages2, predictedStages2] = new_SVMmodel(hrv, stages,...
    'linear','FINAL_generic_SVM_result_ECG.xlsx');

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
confusionMatrix(knownStages1, 1, R6_prediction)
confusionMatrix(knownStages1, 2, R7_prediction)
confusionMatrix(knownStages1, 3, R8_prediction)
confusionMatrix(knownStages1, 4, R9_prediction)
confusionMatrix(knownStages1, 5, R10_prediction)

%% Calculate confusion matrix for approach 2
new_confusionMatrix(knownStages2, predictedStages2)

%% Test a combination of features from ECG and EEG
combo_features = [normFeatures, hrv]; %normFeatures are from function EEGmain

%Approach 1
[knownStages3, predictedStages3, testingData3] ...
    = SVMmodel(combo_features, stages, nSamples, 'linear',...
    'combo_SVM_result.xlsx');

%Approach 2
[knownStages4, predictedStages4] ...
    = new_SVMmodel(combo_features, stages, 'linear',...
    'combo_generic_SVM_result.xlsx');

%% Plot for presentation
figure()
p1 = plot(ECG_R1(1:1000));
hold on;
p2 = plot(preprocessed_R1(1:1000));
xlabel('Time');
legend([p1 p2],{'ECG raw signal','Preprocessed ECG'});