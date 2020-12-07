clear; clc; close all;

%Load signals
edfFilename = 'R1.edf';
[~, record1] = edfread(edfFilename);
edfFilename = 'R2.edf';
[~, record2] = edfread(edfFilename);
edfFilename = 'R3.edf';
[~, record3] = edfread(edfFilename);
edfFilename = 'R4.edf';
[~, record4] = edfread(edfFilename);
edfFilename = 'R5.edf';
[~, record5] = edfread(edfFilename);

%% Get all segements of the signals 
ECG_R1 = record1(4, 1:length(record1));
ECG_R1 = ECG_R1';
ECG_R2 = record2(4, 1:length(record2)); 
ECG_R2 = ECG_R2';
ECG_R3 = record3(4, 1:length(record3)); 
ECG_R3 = ECG_R3';
ECG_R4 = record4(4, 1:length(record4)); 
ECG_R4 = ECG_R4';
ECG_R5 = record5(4, 1:length(record5)); 
ECG_R5 = ECG_R5';

%% Preprocessing
preprocessed_R1 = preprocess(ECG_R1);
preprocessed_R2 = preprocess(ECG_R2);
preprocessed_R3 = preprocess(ECG_R3);
preprocessed_R4 = preprocess(ECG_R4);
preprocessed_R5 = preprocess(ECG_R5);

%% Arrange dataset 
%Each row representing 30s epoch (= 3750 samples)
epoch_R1 = reshape(preprocessed_R1, 3750, []);
epoch_R1 = epoch_R1';
epoch_R2 = reshape(preprocessed_R2, 3750, []);
epoch_R2 = epoch_R2';
epoch_R3 = reshape(preprocessed_R3, 3750, []);
epoch_R3 = epoch_R3';
epoch_R4 = reshape(preprocessed_R4, 3750, []);
epoch_R4 = epoch_R4';
epoch_R5 = reshape(preprocessed_R5, 3750, []);
epoch_R5 = epoch_R5';

%Remove last row to make them match with stages
epoch_R1(end,:) = [];
epoch_R2(end,:) = [];
epoch_R3(end,:) = [];
epoch_R4(end,:) = [];
epoch_R5(end,:) = [];

%Number of samples for each recording
nSamples = [height(epoch_R1);height(epoch_R2);height(epoch_R3);...
    height(epoch_R4);height(epoch_R5)]; 

%% Get RR intervals
RRInterval_R1 = findRRinterval(epoch_R1, height(epoch_R1));
RRInterval_R2 = findRRinterval(epoch_R2, height(epoch_R2));
RRInterval_R3 = findRRinterval(epoch_R3, height(epoch_R3));
RRInterval_R4 = findRRinterval(epoch_R4, height(epoch_R4));
RRInterval_R5 = findRRinterval(epoch_R5, height(epoch_R5));

%% Extract features
hrv_R1 = extractfeatures(RRInterval_R1);
hrv_R2 = extractfeatures(RRInterval_R2);
hrv_R3 = extractfeatures(RRInterval_R3);
hrv_R4 = extractfeatures(RRInterval_R4);
hrv_R5 = extractfeatures(RRInterval_R5);
hrv = [hrv_R1;hrv_R2;hrv_R3;hrv_R4;hrv_R5]; %feature matrix

%% Save features as xlsx file
% R1 = sym('R1_', [1084 1]);
% R2 = sym('R2_', [1079 1]);
% R3 = sym('R3_', [1049 1]);
% R4 = sym('R4_', [875 1]);
% R5 = sym('R5_', [1084 1]);
% R = [R1;R2;R3;R4;R5];
% R = arrayfun(@char, R, 'uniform', 0);
% 
% filename = 'hrv_features.xlsx';
% writecell({'Recording', 'AVNN', 'SDNN', 'RMSSD', 'SDSD', 'NN50', 'pNN50'...
%     'HRV Triangular index', 'SD1', 'SD2', 'Ratio of SD&SD2'...
%     'Area of ellipse', 'TP', 'pLF', 'pHF', 'LHF ratio', 'VLF'...
%     'LF', 'HF'} ,filename);
% writecell(R, filename,'Range','A2');
% writematrix(hrv, filename,'Range','B2');

%% Load and arrange stages
[~, stages_R1, ~, ~] = readXML('R1.xml');
[~, stages_R2, ~, ~] = readXML('R2.xml');
[~, stages_R3, ~, ~] = readXML('R3.xml');
[~, stages_R4, ~, ~] = readXML('R4.xml');
[~, stages_R5, ~, ~] = readXML('R5.xml');

stages_R1 = reshape(stages_R1, 30, []);
stages_R1 = stages_R1';
stages_R2 = reshape(stages_R2, 30, []);
stages_R2 = stages_R2';
stages_R3 = reshape(stages_R3, 30, []);
stages_R3 = stages_R3';
stages_R4 = reshape(stages_R4, 30, []);
stages_R4 = stages_R4';
stages_R5 = reshape(stages_R5, 30, []);
stages_R5 = stages_R5';
stages = [stages_R1;stages_R2;stages_R3;stages_R4;stages_R5];

%% Create SVM model
[knownStages, predictedStages, testAcc,...
    trainAcc] = SVMmodel(hrv, stages, nSamples);

%% plot Hypnogram (sleep stages over time)
%0-REM, 2-N2, 3-N2, 4-N3, 5-Wake

%s = knownStages(:,2);
s = predictedStages(:,2);

figure(1);
plot(((1:length(s))*30)/60, s); 
ylim([0 6]);
set(gca,'ytick',[0:6],'yticklabel',{'REM','','N3','N2','N1','Wake',''});
xlabel('Time (Minutes)');
ylabel('Sleep Stage');
box off;
title('Hypnogram');
set(gcf,'color','w');

%% Calculate confusion matrix
%Get predictions for each recording
R1_prediction = predictedStages(1:324, 1);
R2_prediction = predictedStages(1:322, 2);
R3_prediction = predictedStages(1:313, 3);
R4_prediction = predictedStages(1:261, 4);
R5_prediction = predictedStages(1:324, 5);

%%
confusionMatrix(knownStages, 1, R1_prediction)
%%
confusionMatrix(knownStages, 2, R2_prediction)
%%
confusionMatrix(knownStages, 3, R3_prediction)
%%
confusionMatrix(knownStages, 4, R4_prediction)
%%
confusionMatrix(knownStages, 5, R5_prediction)
