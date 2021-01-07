function filtered_EEG = preprocess_EEG(EEG)

Fs = 125; %Sampling frequency

%Remove the DC component 
EEG_withoutDC = EEG - mean(EEG);

% New Butter filter
Fn = Fs/2;                             % Nyquist Frequency (Hz)
Wp = [5   25]/Fn;                      % Normalised Passband 
Ws = [4 26]/Fn;                        % Normalised Stopband 
Rp =  5;                               % Passband Ripple/Attenuation
Rs = 10;                               % Stopband Ripple/Attenuation
[n,Wn] = buttord(Wp, Ws, Rp, Rs);      % Calculate Filter Optimum Order
[z,p,k] = butter(n, Wn,'bandpass');    % Create Filter
[sos,g] = zp2sos(z,p,k);               % Second-Order-Section For Stability


% Apply filter to signal
filtered_EEG = filtfilt(sos, g, EEG_withoutDC);

%Plot EEG signal
figure;
plot(filtered_EEG)

end 