function [Alpha, Beta, Theta, Delta, Gamma] =  waveletTransform(filtered_EEG)

waveletFunction = 'db8';

[C,L] = wavedec(filtered_EEG, 8, waveletFunction); %Wavelet on filtered signal
       
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


end
