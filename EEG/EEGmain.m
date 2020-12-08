%% Load signals
clc;
clear all;

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

%%
Fs = 125; % Sampling frequency, Hz 
EEG = record1(8, 1:length(record1));
EEG2 = record2(8, 1:length(record2));
EEG3 = record3(8, 1:length(record3));
EEG4 = record4(8, 1:length(record4));
EEG5 = record5(8, 1:length(record5));


%% Design a Bandpass Filter for Pre-rpocessing
% Butter filter
lowEnd = 2; % Hz
highEnd = 50; % Hz
filterOrder = 2; 
[b, a] = butter(filterOrder, [lowEnd highEnd]/(Fs/2)); % Generate filter coefficients


%% Apply filter to signal
filtered_EEG1 = filtfilt(b, a, EEG); 
filtered_EEG2 = filtfilt(b, a, EEG2);
filtered_EEG3 = filtfilt(b, a, EEG3);
filtered_EEG4 = filtfilt(b, a, EEG4);
filtered_EEG5 = filtfilt(b, a, EEG5);

%% ---- DISCRETE WAVELET TRANSFORM --------
%(5 level wavelet db2)
[Alpha1, Beta1, Theta1, Delta1, Gamma1] =  waveletTransform(filtered_EEG1);
[Alpha2, Beta2, Theta2, Delta2, Gamma2] =  waveletTransform(filtered_EEG2);
[Alpha3, Beta3, Theta3, Delta3, Gamma3] =  waveletTransform(filtered_EEG3);
[Alpha4, Beta4, Theta4, Delta4, Gamma4] =  waveletTransform(filtered_EEG4);
[Alpha5, Beta5, Theta5, Delta5, Gamma5] =  waveletTransform(filtered_EEG5);

%% Arrange dimensions for signals and features
[R1_Epoch, Alpha1, Beta1, Theta1, Delta1, Gamma1] = arrangeDataEEG(filtered_EEG1, Alpha1, Beta1, Theta1, Delta1, Gamma1);
[R2_Epoch, Alpha2, Beta2, Theta2, Delta2, Gamma2] = arrangeDataEEG(filtered_EEG2, Alpha2, Beta2, Theta2, Delta2, Gamma2);
[R3_Epoch, Alpha3, Beta3, Theta3, Delta3, Gamma3] = arrangeDataEEG(filtered_EEG3, Alpha3, Beta3, Theta3, Delta3, Gamma3);
[R4_Epoch, Alpha4, Beta4, Theta4, Delta4, Gamma4] = arrangeDataEEG(filtered_EEG4, Alpha4, Beta4, Theta4, Delta4, Gamma4);
[R5_Epoch, Alpha5, Beta5, Theta5, Delta5, Gamma5] = arrangeDataEEG(filtered_EEG5, Alpha5, Beta5, Theta5, Delta5, Gamma5);

nSamples = [height(R1_Epoch);height(R2_Epoch);height(R3_Epoch);height(R4_Epoch);height(R5_Epoch)];

%% Extract features
NEWfeatures1 = extractFeaturesEEG(R1_Epoch, Alpha1, Beta1, Theta1, Delta1, Gamma1);
NEWfeatures2 = extractFeaturesEEG(R2_Epoch, Alpha2, Beta2, Theta2, Delta2, Gamma2);
NEWfeatures3 = extractFeaturesEEG(R3_Epoch, Alpha3, Beta3, Theta3, Delta3, Gamma3);
NEWfeatures4 = extractFeaturesEEG(R4_Epoch, Alpha4, Beta4, Theta4, Delta4, Gamma4);
NEWfeatures5 = extractFeaturesEEG(R5_Epoch, Alpha5, Beta5, Theta5, Delta5, Gamma5);
%%
NEWfeatures = [NEWfeatures1;NEWfeatures2;NEWfeatures3;NEWfeatures4;NEWfeatures5]; %feature matrix
NEWfeatures_norm = normalize(NEWfeatures); %normalize features

%% Save features as mat files
% save('NormFeaturesEEG.mat', 'NEWfeatures_norm');
% save('FeaturesEEG.mat', 'NEWfeatures');

%% Save features as xlsx files
% saveFeaturesEEG(NEWfeatures_norm, 'NormFeaturesEEG.xlsx');
% saveFeaturesEEG(NEWfeatures, 'FeaturesEEG.xlsx');

%% Load features
normFeatures = load('NormFeaturesEEG.mat');
fieldName = fieldnames(normFeatures);
normFeatures = normFeatures.(fieldName{1});

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

stages = [stages_R1; stages_R2; stages_R3; stages_R4; stages_R5];

%% SVM model
[knownStages, predictions_test, testAcc, trainAcc] = SVMmodel(normFeatures, stages, nSamples, 'linear', 'SVM_result_EEG.xlsx');

%% Hypnogram ground truth R1
%[events, stages, epochLength,annotation] = readXML('R1.xml');
figure(2);
%stages = stages(1:8000);
plot(((1:length(stages_R1))*30)/60,stages_R1); %sleep stages are for 30 seconds epochs
ylim([0 6]);
set(gca,'ytick',[0:6],'yticklabel',{'REM','','N3','N2','N1','Wake',''});
xlabel('Time (Minutes)');ylabel('Sleep Stage');box off;title('Hypnogram');
set(gcf,'color','w');

%% Hypnogram ground truth R2
%[events, stages2, epochLength,annotation] = readXML('R2.xml');
figure(2);
plot(((1:length(stages_R2))*30)/60,stages_R2); %sleep stages are for 30 seconds epochs
ylim([0 6]);
set(gca,'ytick',[0:6],'yticklabel',{'REM','','N3','N2','N1','Wake',''});
xlabel('Time (Minutes)');ylabel('Sleep Stage');box off;title('Hypnogram');
set(gcf,'color','w');


%% 
figure(3);
plot(((1:length(predictedStages(:,2)))*30)/60,predictedStages(:,2)); %sleep stages are for 30 seconds epochs
ylim([0 6]);
set(gca,'ytick',[0:6],'yticklabel',{'REM','','N3','N2','N1','Wake',''});
xlabel('Time (Minutes)');ylabel('Sleep Stage');box off;title('Hypnogram');
set(gcf,'color','w');

% figure(4);
% plot(((1:length(knownStages(:,2)))*30)/60,knownStages(:,2)); %sleep stages are for 30 seconds epochs
% ylim([0 6]);
% set(gca,'ytick',[0:6],'yticklabel',{'REM','','N3','N2','N1','Wake',''});
% xlabel('Time (Minutes)');ylabel('Sleep Stage');box off;title('Hypnogram');
% set(gcf,'color','w');

% figure(4);
% plot(((1:length(stages_R2(1:340)))*30)/60,stages_R2(1:340)); %sleep stages are for 30 seconds epochs
% ylim([0 6]);
% set(gca,'ytick',[0:6],'yticklabel',{'REM','','N3','N2','N1','Wake',''});
% xlabel('Time (Minutes)');ylabel('Sleep Stage');box off;title('Hypnogram');
% set(gcf,'color','w');
