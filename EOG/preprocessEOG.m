function processed = preprocessEOG(EOG)

%Remove the DC component 
EOG_withoutDC = EOG - mean(EOG);

% Remove BW
Fs = 125; %sampling frequency
EOG_withoutBW = idealfilter(timeseries(EOG_withoutDC),[0 10/Fs],'pass');
EOG_withoutDCBW = EOG_withoutDC - squeeze(EOG_withoutBW.Data);

%apply Median filter 1D
medFilt = dsp.MedianFilter(10);
EOG_median = medFilt(EOG_withoutDCBW);

processed= bandpass(EOG_median,[0.5 30]/(Fs/2));


% 
% %filter from paper: the low-pass filtering is realized with the 32 order low-pass FIR filter and the cut-off frequency is 30 Hz.
% d=designfilt('lowpassfir', 'FilterOrder', 32, 'CutoffFrequency',30/(Fs/2), 'SampleRate',Fs);
% y=filter(d, EOG_median);
% 
% %the high-pass FIR filter and the cut-off frequency is 1.5 Hz. The Chebyshev window with 20 decibels of relative sidelobe attenuation is also used. The order of the filter is 62. 
% chebhi = fir1(62,1.5/(Fs/2),'high',chebwin(63,20));
% z=filter(chebhi,1,y);
% 
% %the low-pass FIR filtering is implemented, the order of the filter is 60, the cutoff frequency is 8 Hz, and the Chebyshev window with 20 decibels of relative sidelobe attenuation is also used. 
% cheblow = fir1(60,8/(Fs/2),'low',chebwin(61,20));
% processed=filter(cheblow,1,z);

end 
