function hrv = extractfeatures(RLocsInterval)

nSamples = size(RLocsInterval, 1);
hrv = zeros(nSamples, 18);

for i = 1:nSamples
    
    rr_diff = diff(RLocsInterval{i});
    
    %Time domain features
    hrv(i, 1) = mean(RLocsInterval{i}); %AVNN - average of RR intervals
    hrv(i, 2) = std(RLocsInterval{i}); %SDNN - SD of RR intervals
    hrv(i, 3) = sqrt(mean(rr_diff.^2)); %RMSSD - square root of the mean squared diff of successive RR intervals
    hrv(i, 4) = std(rr_diff); %SDSD - SD of the difference of successive RR interval
    hrv(i, 5) = sum((rr_diff*1000)>50); %NN50 - Number of successive RR interval which is more than 50 ms
    hrv(i, 6) = (hrv(i, 5)/(size(RLocsInterval{i}, 2) - 1))*100; %pNN50 - The proportion of NN50 divided by the total number of NN (R-R) intervals
    
    %Geometrical feature
    hrv(i, 7) = HRVFeatureFunctions.HRV_TRIANGULAR_IDX(RLocsInterval{i}); %HRV Triangular Index
    
    %Pointcare features
    hrv(i, 8) = sqrt((hrv(i, 4)^2)/2); %SD1 - SD from a point perpendicular to the line of identity line
    hrv(i, 9) = sqrt(2*(hrv(i, 2)^2)-(hrv(i, 4)^2)/2); %SD2 - SD rom the point along the line of identity line
    hrv(i, 10) = hrv(i, 8)/hrv(i, 9); %ratio of SD1 and SD2
    hrv(i, 11) = pi*hrv(i, 8)*hrv(i, 9); %area of ellipse
    
    
    %without EOG its hard to distinghusig between wake and rem
   
    
    % maybe not use, 30s is too short for this
    %Frequency domain features
    [TP,pLF,pHF,LFHFratio,VLF,LF,HF,f,Y,NFFT] = ...
        HRVFeatureFunctions.fft_val_fun(RLocsInterval{i},2);
    hrv(i, 12) = TP; %total power
    hrv(i, 13) = pLF;
    hrv(i, 14) = pHF;
    hrv(i, 15) = LFHFratio; %ratio between LF and HF
    hrv(i, 16) = VLF; %very low frequency
    hrv(i, 17) = LF; %low frequency
    hrv(i, 18) = HF; %high frequency
end
end
