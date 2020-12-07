function processedECG = preprocess(ECG)

%Remove the DC component 
ECG_withoutDC = ECG - mean(ECG);

% Remove BW
Fs = 125; %sampling frequency
ECG_withoutBW = idealfilter(timeseries(ECG_withoutDC),[0 10/Fs],'pass');
ECG_withoutDCBW = ECG_withoutDC - squeeze(ECG_withoutBW.Data);

% Apply Notch filter
[num,den] = iirnotch(60/(Fs/2),0.25/(Fs/2));
processedECG = filter(num, den, ECG_withoutDCBW);

end 