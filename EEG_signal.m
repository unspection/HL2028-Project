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

%% Old code
% epochNumber = 300; % plot nth epoch of 30 seconds    
% epochStart = (epochNumber*Fs*30);    
% epochEnd = epochStart + 30*Fs;

% Extract Channel 8 and perform epoching to get 1280 samples
% EEG = record(8, epochStart:epochEnd);
% EEG2 = record2(8, epochStart:epochEnd);

%% Design a Bandpass Filter for Pre-rpocessing
% Butter filter
lowEnd = 2; % Hz
highEnd = 50; % Hz
filterOrder = 2; 
[b, a] = butter(filterOrder, [lowEnd highEnd]/(Fs/2)); % Generate filter coefficients


%% Apply filter to signal
filtered_EEG = filtfilt(b, a, EEG); 
filtered_EEG2 = filtfilt(b, a, EEG2);
filtered_EEG3 = filtfilt(b, a, EEG3);
filtered_EEG4 = filtfilt(b, a, EEG4);
filtered_EEG5 = filtfilt(b, a, EEG5);

%filtered_EEG = smoothdata(filtered_EEG1);

%Plot EEG signal
figure;
plot(filtered_EEG)


%% ---- DISCRETE WAVELET TRANSFORM --------
%(5 level wavelet db2)

%-- EEG R1 ---
N=length(filtered_EEG);

waveletFunction = 'db8';
                [C,L] = wavedec(filtered_EEG,8,waveletFunction); %Wavelet on filtered signal
       
                cD1 = detcoef(C,L,1);
                cD2 = detcoef(C,L,2);
                cD3 = detcoef(C,L,3);
                cD4 = detcoef(C,L,4);
                cD5 = detcoef(C,L,5); %GAMA
                cD6 = detcoef(C,L,6); %BETA
                cD7 = detcoef(C,L,7); %ALPHA
                cD8 = detcoef(C,L,8); %THETA
                cA8 = appcoef(C,L,waveletFunction,8); %DELTA
                D1 = wrcoef('d',C,L,waveletFunction,1);
                D2 = wrcoef('d',C,L,waveletFunction,2);
                D3 = wrcoef('d',C,L,waveletFunction,3);
                D4 = wrcoef('d',C,L,waveletFunction,4);
                D5 = wrcoef('d',C,L,waveletFunction,5); %GAMMA
                D6 = wrcoef('d',C,L,waveletFunction,6); %BETA
                D7 = wrcoef('d',C,L,waveletFunction,7); %ALPHA
                D8 = wrcoef('d',C,L,waveletFunction,8); %THETA
                A8 = wrcoef('a',C,L,waveletFunction,8); %DELTA
                
                Gamma = D5;
                 figure; subplot(5,1,1); plot(1:1:length(Gamma),Gamma);title('GAMMA');
               
                Beta = D6;
                subplot(5,1,2); plot(1:1:length(Beta), Beta); title('BETA');
                
                Alpha = D7;
                subplot(5,1,3); plot(1:1:length(Alpha),Alpha); title('ALPHA'); 
                
                Theta = D8;
                subplot(5,1,4); plot(1:1:length(Theta),Theta);title('THETA');
                D8 = detrend(D8,0);
                
                Delta = A8;
                %figure, plot(0:1/fs:1,Delta);
                subplot(5,1,5);plot(1:1:length(Delta),Delta);title('DELTA');
                
%
% D5 = detrend(D5,0);
% xdft = fft(D5);
% freq = 0:N/length(D5):N/2;
% xdft = xdft(1:length(D5)/2+1);
% figure;
% subplot(511);
% plot(freq,abs(xdft));
% title('GAMMA-FREQUENCY');
% 
% D6 = detrend(D6,0);
% xdft2 = fft(D6);
% freq2 = 0:N/length(D6):N/2;
% xdft2 = xdft2(1:length(D6)/2+1);
% subplot(512);
% plot(freq2,abs(xdft2));
% title('BETA');
% 
% D7 = detrend(D7,0);
% xdft3 = fft(D7);
% freq3 = 0:N/length(D7):N/2;
% xdft3 = xdft3(1:length(D7)/2+1);
% subplot(513);
% plot(freq3,abs(xdft3));title('ALPHA');          
%  
% xdft4 = fft(D8);
% freq4 = 0:N/length(D8):N/2;
% xdft4 = xdft4(1:length(D8)/2+1);
% subplot(514);
% plot(freq4,abs(xdft4));
% title('THETA');
% 
% A8 = detrend(A8,0);
% xdft5 = fft(A8);
% freq5 = 0:N/length(A8):N/2;
% xdft5 = xdft5(1:length(A8)/2+1);
% subplot(515);
% plot(freq3,abs(xdft5));
% title('DELTA');

%------ EEG R2 -----
N=length(filtered_EEG2);

waveletFunction2 = 'db8';
                [C2,L2] = wavedec(filtered_EEG2,8,waveletFunction2); %Wavelet on filtered signal
       
                cD1_2 = detcoef(C2,L2,1);
                cD2_2 = detcoef(C2,L2,2);
                cD3_2 = detcoef(C2,L2,3);
                cD4_2 = detcoef(C2,L2,4);
                cD5_2 = detcoef(C2,L2,5); %GAMA
                cD6_2 = detcoef(C2,L2,6); %BETA
                cD7_2 = detcoef(C2,L2,7); %ALPHA
                cD8_2 = detcoef(C2,L2,8); %THETA
                cA8_2 = appcoef(C2,L2,waveletFunction2,8); %DELTA
                D1_2 = wrcoef('d',C2,L2,waveletFunction2,1);
                D2_2 = wrcoef('d',C2,L2,waveletFunction2,2);
                D3_2 = wrcoef('d',C2,L2,waveletFunction2,3);
                D4_2 = wrcoef('d',C2,L2,waveletFunction2,4);
                D5_2 = wrcoef('d',C2,L2,waveletFunction2,5); %GAMMA
                D6_2 = wrcoef('d',C2,L2,waveletFunction2,6); %BETA
                D7_2 = wrcoef('d',C2,L2,waveletFunction2,7); %ALPHA
                D8_2 = wrcoef('d',C2,L2,waveletFunction2,8); %THETA
                A8_2 = wrcoef('a',C2,L2,waveletFunction2,8); %DELTA
                
                Gamma2 = D5_2;
                 figure; subplot(5,1,1); plot(1:1:length(Gamma2),Gamma2);title('GAMMA');
               
                Beta2 = D6_2;
                subplot(5,1,2); plot(1:1:length(Beta2), Beta2); title('BETA');
                
                Alpha2 = D7_2;
                subplot(5,1,3); plot(1:1:length(Alpha2),Alpha2); title('ALPHA'); 
                
                Theta2 = D8_2;
                subplot(5,1,4); plot(1:1:length(Theta2),Theta2);title('THETA');
                D8 = detrend(D8,0);
                
                Delta2 = A8_2;
                subplot(5,1,5);plot(1:1:length(Delta2),Delta2);title('DELTA');
                
%------ EEG R3 -----
N=length(filtered_EEG3);

waveletFunction3 = 'db8';
                [C2,L2] = wavedec(filtered_EEG3,8,waveletFunction3); %Wavelet on filtered signal
       
                cD1_3 = detcoef(C2,L2,1);
                cD2_3 = detcoef(C2,L2,2);
                cD3_3 = detcoef(C2,L2,3);
                cD4_3 = detcoef(C2,L2,4);
                cD5_3 = detcoef(C2,L2,5); %GAMA
                cD6_3 = detcoef(C2,L2,6); %BETA
                cD7_3 = detcoef(C2,L2,7); %ALPHA
                cD8_3 = detcoef(C2,L2,8); %THETA
                cA8_3 = appcoef(C2,L2,waveletFunction3,8); %DELTA
                D1_3 = wrcoef('d',C2,L2,waveletFunction3,1);
                D2_3 = wrcoef('d',C2,L2,waveletFunction3,2);
                D3_3 = wrcoef('d',C2,L2,waveletFunction3,3);
                D4_3 = wrcoef('d',C2,L2,waveletFunction3,4);
                D5_3 = wrcoef('d',C2,L2,waveletFunction3,5); %GAMMA
                D6_3 = wrcoef('d',C2,L2,waveletFunction3,6); %BETA
                D7_3 = wrcoef('d',C2,L2,waveletFunction3,7); %ALPHA
                D8_3 = wrcoef('d',C2,L2,waveletFunction3,8); %THETA
                A8_3 = wrcoef('a',C2,L2,waveletFunction3,8); %DELTA
                
                Gamma3 = D5_3;
                 figure; subplot(5,1,1); plot(1:1:length(Gamma3),Gamma3);title('GAMMA');
               
                Beta3 = D6_3;
                subplot(5,1,2); plot(1:1:length(Beta3), Beta3); title('BETA');
                
                Alpha3 = D7_3;
                subplot(5,1,3); plot(1:1:length(Alpha3),Alpha3); title('ALPHA'); 
                
                Theta3 = D8_3;
                subplot(5,1,4); plot(1:1:length(Theta3),Theta3);title('THETA');
                D8 = detrend(D8,0);
                
                Delta3 = A8_3;
                subplot(5,1,5);plot(1:1:length(Delta3),Delta3);title('DELTA');
                
                
                
%------ EEG R4 -----
N=length(filtered_EEG4);

waveletFunction4 = 'db8';
                [C2,L2] = wavedec(filtered_EEG4,8,waveletFunction4); %Wavelet on filtered signal
       
                cD1_4 = detcoef(C2,L2,1);
                cD2_4 = detcoef(C2,L2,2);
                cD3_4 = detcoef(C2,L2,3);
                cD4_4 = detcoef(C2,L2,4);
                cD5_4 = detcoef(C2,L2,5); %GAMA
                cD6_4 = detcoef(C2,L2,6); %BETA
                cD7_4 = detcoef(C2,L2,7); %ALPHA
                cD8_4 = detcoef(C2,L2,8); %THETA
                cA8_4 = appcoef(C2,L2,waveletFunction4,8); %DELTA
                D1_4 = wrcoef('d',C2,L2,waveletFunction4,1);
                D2_4 = wrcoef('d',C2,L2,waveletFunction4,2);
                D3_4 = wrcoef('d',C2,L2,waveletFunction4,3);
                D4_4 = wrcoef('d',C2,L2,waveletFunction4,4);
                D5_4 = wrcoef('d',C2,L2,waveletFunction4,5); %GAMMA
                D6_4 = wrcoef('d',C2,L2,waveletFunction4,6); %BETA
                D7_4 = wrcoef('d',C2,L2,waveletFunction4,7); %ALPHA
                D8_4 = wrcoef('d',C2,L2,waveletFunction4,8); %THETA
                A8_4 = wrcoef('a',C2,L2,waveletFunction4,8); %DELTA
                
                Gamma4 = D5_4;
                 figure; subplot(5,1,1); plot(1:1:length(Gamma4),Gamma4);title('GAMMA');
               
                Beta4 = D6_4;
                subplot(5,1,2); plot(1:1:length(Beta4), Beta4); title('BETA');
                
                Alpha4 = D7_4;
                subplot(5,1,3); plot(1:1:length(Alpha4),Alpha4); title('ALPHA'); 
                
                Theta4 = D8_4;
                subplot(5,1,4); plot(1:1:length(Theta4),Theta4);title('THETA');
                D8 = detrend(D8,0);
                
                Delta4 = A8_4;
                subplot(5,1,5);plot(1:1:length(Delta4),Delta4);title('DELTA');
                
                
                
%------ EEG R5 -----
N=length(filtered_EEG5);

waveletFunction5 = 'db8';
                [C2,L2] = wavedec(filtered_EEG5,8,waveletFunction5); %Wavelet on filtered signal
       
                cD1_5 = detcoef(C2,L2,1);
                cD2_5 = detcoef(C2,L2,2);
                cD3_5 = detcoef(C2,L2,3);
                cD4_5 = detcoef(C2,L2,4);
                cD5_5 = detcoef(C2,L2,5); %GAMA
                cD6_5 = detcoef(C2,L2,6); %BETA
                cD7_5 = detcoef(C2,L2,7); %ALPHA
                cD8_5 = detcoef(C2,L2,8); %THETA
                cA8_5 = appcoef(C2,L2,waveletFunction5,8); %DELTA
                D1_5 = wrcoef('d',C2,L2,waveletFunction5,1);
                D2_5 = wrcoef('d',C2,L2,waveletFunction5,2);
                D3_5 = wrcoef('d',C2,L2,waveletFunction5,3);
                D4_5 = wrcoef('d',C2,L2,waveletFunction5,4);
                D5_5 = wrcoef('d',C2,L2,waveletFunction5,5); %GAMMA
                D6_5 = wrcoef('d',C2,L2,waveletFunction5,6); %BETA
                D7_5 = wrcoef('d',C2,L2,waveletFunction5,7); %ALPHA
                D8_5 = wrcoef('d',C2,L2,waveletFunction5,8); %THETA
                A8_5 = wrcoef('a',C2,L2,waveletFunction5,8); %DELTA
                
                Gamma5 = D5_5;
                 figure; subplot(5,1,1); plot(1:1:length(Gamma5),Gamma5);title('GAMMA');
               
                Beta5 = D6_5;
                subplot(5,1,2); plot(1:1:length(Beta5), Beta5); title('BETA');
                
                Alpha5 = D7_5;
                subplot(5,1,3); plot(1:1:length(Alpha5),Alpha5); title('ALPHA'); 
                
                Theta5 = D8_5;
                subplot(5,1,4); plot(1:1:length(Theta5),Theta5);title('THETA');
                D8 = detrend(D8,0);
                
                Delta5 = A8_5;
                subplot(5,1,5);plot(1:1:length(Delta5),Delta5);title('DELTA');

%% Arrange dimentions - Waveforms
%R1 waves
alpha = reshape(Alpha,3750,[]);
alpha = alpha';
beta = reshape(Beta,3750,[]);
beta = beta';
theta = reshape(Theta,3750,[]);
theta = theta';
delta = reshape(Delta,3750,[]);
delta = delta';
gamma = reshape(Gamma,3750,[]);
gamma = gamma';

% R2 waves
alpha2 = reshape(Alpha2,3750,[]);
alpha2 = alpha2';
beta2 = reshape(Beta2,3750,[]);
beta2 = beta2';
theta2 = reshape(Theta2,3750,[]);
theta2 = theta2';
delta2 = reshape(Delta2,3750,[]);
delta2 = delta2';
gamma2 = reshape(Gamma2,3750,[]);
gamma2 = gamma2';    

% R3 waves
alpha3 = reshape(Alpha3,3750,[]);
alpha3 = alpha3';
beta3= reshape(Beta3,3750,[]);
beta3 = beta3';
theta3 = reshape(Theta3,3750,[]);
theta3 = theta3';
delta3 = reshape(Delta3,3750,[]);
delta3 = delta3';
gamma3 = reshape(Gamma3,3750,[]);
gamma3 = gamma3'; 

% R4 waves
alpha4 = reshape(Alpha4,3750,[]);
alpha4 = alpha4';
beta4 = reshape(Beta4,3750,[]);
beta4 = beta4';
theta4 = reshape(Theta4,3750,[]);
theta4 = theta4';
delta4 = reshape(Delta4,3750,[]);
delta4 = delta4';
gamma4 = reshape(Gamma4,3750,[]);
gamma4 = gamma4'; 

% R5 waves
alpha5 = reshape(Alpha5,3750,[]);
alpha5 = alpha5';
beta5 = reshape(Beta5,3750,[]);
beta5 = beta5';
theta5 = reshape(Theta5,3750,[]);
theta5 = theta5';
delta5 = reshape(Delta5,3750,[]);
delta5 = delta5';
gamma5 = reshape(Gamma5,3750,[]);
gamma5 = gamma5'; 



%% Arrange dataset (30s epoch = 34750 samples)
R1_Epoch = reshape(filtered_EEG,3750,[]);
R1_Epoch = R1_Epoch';
R2_Epoch = reshape(filtered_EEG2, 3750, []);
R2_Epoch = R2_Epoch';
R3_Epoch = reshape(filtered_EEG3, 3750, []);
R3_Epoch = R3_Epoch';
R4_Epoch = reshape(filtered_EEG4, 3750, []);
R4_Epoch = R4_Epoch';
R5_Epoch = reshape(filtered_EEG5, 3750, []);
R5_Epoch = R5_Epoch';

% Remove last row to make them match with stages
R1_Epoch(end,:) = [];
R2_Epoch(end,:) = [];
R3_Epoch(end,:) = [];
R4_Epoch(end,:) = [];
R5_Epoch(end,:) = [];
%%
%Number of samples for each recording
nSamples = [height(R1_Epoch);height(R2_Epoch);height(R3_Epoch);height(R4_Epoch);height(R5_Epoch)]; 
                
%% Load and arrange stages
%0-REM, 2-N2, 3-N2, 4-N3, 5-Wake
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

%% Correct dimension 
% stages = stages';
% stages2 = stages2';
% EEG_labeled = [filtered_EEG(1:length(stages_R1)),stages,Alpha(1:length(stages_R1)),Beta(1:length(stages_R1)),Theta(1:length(stages_R1)),Delta(1:length(stages_R1))];
% 
% plot(EEG_labeled(400:900,:))

%EEG_labeled = [filtered_EEG,stages_R1,alpha,beta,delta,theta,gamma];

%% Prediction With the Classification app  
% X = [filtered_EEG(1:length(stages)),alpha(1:length(stages)),beta(1:length(stages)),theta(1:length(stages)),delta(1:length(stages))];
% %filtered_EEG = filtered_EEG2;
% %Y = [filtered_EEG(1:length(stages)),alpha(1:length(stages)),beta(1:length(stages)),theta(1:length(stages)),delta(1:length(stages))];
% %yfit = trainedModelEEG.predictFcn(X); %prediciton EEG
% yfit2 = trainedModelEEG.predictFcn(Y); %prediction EEG2
% stages = yfit2;
% EEG_labeled_trained = [filtered_EEG(1:length(stages_R1)),stages_R1, alpha(1:length(stages_R1)),beta(1:length(stages_R1)),theta(1:length(stages_R1)),delta(1:length(stages_R1))];
% %plot(EEG_labeled_trained2(400:900,:))

%% Hypnogram predicted from using the app
% figure(2);
% plot(((1:length(stages))*30)/60,stages); %sleep stages are for 30 seconds epochs
% ylim([0 6]);
% set(gca,'ytick',[0:6],'yticklabel',{'REM','','N3','N2','N1','Wake',''});
% xlabel('Time (Minutes)');ylabel('Sleep Stage');box off;title('Hypnogram');
% set(gcf,'color','w');

%% Train on R1 & R2
%stages2 = stages2';
% EEG_labeled_large = [filtered_EEG(1:length(stages_R1)),stages_R1, Alpha(1:length(stages)),Beta(1:length(stages)),Theta(1:length(stages)),Delta(1:length(stages));filtered_EEG2(1:length(stages2)),stages2,Alpha2(1:length(stages2)),Beta2(1:length(stages2)),Theta2(1:length(stages2)),Delta2(1:length(stages2))];
%  
%% Features matrix
features_R1 = [alpha beta delta theta];
features_R2 = [alpha2 beta2 delta2 theta2];
features_R3 = [alpha3 beta3 delta3 theta3];
features_R4 = [alpha4 beta4 delta4 theta4];
features_R5 = [alpha5 beta5 delta5 theta5];

%% Stages matrix
stages = [stages_R1; stages_R2; stages_R3; stages_R4; stages_R5];

wave_features = [features_R1; features_R2; features_R3; features_R4; features_R5];
wave_features = wave_features(1:length(stages),:);

%% Whole matrix
% EEG_labeled_matrix = [wave_features, stages];
% EEG_labeled_matrix = EEG_labeled_matrix';
% %% test with only R1
% features_R1 = features_R1(1:length(stages_R1),:);
%% SVM model
[knownStages, predictedStages, predictions_train, testAcc, trainAcc] = SVMmodel(wave_features, stages, nSamples);

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



