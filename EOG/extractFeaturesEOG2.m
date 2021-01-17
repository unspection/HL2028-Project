function EOGfeatures = extractFeaturesEOG2(eogsignalleft,rawleft,eogsignalright,rawright,delta)

nSamples = size(eogsignalleft, 1);
EOGfeatures= zeros(nSamples,19);

for i = 1:nSamples
   
    %Time domain features
    %left
    EOGfeatures(i, 1) = mean(eogsignalleft(i,:)); %absolute mean 
    EOGfeatures(i, 2) = sum(eogsignalleft(i,:).^2); %energy of signal
    EOGfeatures(i, 3) = rms(eogsignalleft(i,:))/mean(sqrt(abs(eogsignalleft(i,:)))); %form factor of signal
    EOGfeatures(i, 4) = std(eogsignalleft(i,:)); %standard deviation
    EOGfeatures(i, 5) = skewness(eogsignalleft(i,:)); %skewness of signal
    EOGfeatures(i, 6) = kurtosis(eogsignalleft(i,:)); %kurtosis of signal 
    %right
    EOGfeatures(i, 7) = mean(eogsignalright(i,:)); %absolute mean 
    EOGfeatures(i, 8) = sum(eogsignalright(i,:).^2); %energy of signal
    EOGfeatures(i, 9) = rms(eogsignalright(i,:))/mean(sqrt(abs(eogsignalright(i,:)))); %form factor of signal
    EOGfeatures(i, 10) = std(eogsignalright(i,:)); %standard deviation
    EOGfeatures(i, 11) = skewness(eogsignalright(i,:)); %skewness of signal
    EOGfeatures(i, 12) = kurtosis(eogsignalright(i,:)); %kurtosis of signal 
    %frequency domain features
    
    %power in bands 0-2Hz and 2-4Hz
    [pxx,f] = pwelch(eogsignalleft(i,1:end-1),[],[],[0 2],50); %power 0-2Hz left
    EOGfeatures(i, 13) = mean(pxx);
    [pxx,f] = pwelch(eogsignalright(i,1:end-1),[],[],[0 2],50);%power 0-2Hz right
    EOGfeatures(i, 14) = mean(pxx);
    [pxx,f] = pwelch(eogsignalleft(i,1:end-1),[],[],[2 4],50);%power 2-4Hz left
    EOGfeatures(i, 15) = mean(pxx);
    [pxx,f] = pwelch(eogsignalright(i,1:end-1),[],[],[2 4],50);%power 2-4Hz right
    EOGfeatures(i, 16) = mean(pxx);
       
    EOGfeatures(i,17) = mean(delta(i,:)); %absolute mean of difference
    EOGfeatures(i,18) = std(delta(i,:)); %absolute standard deviation of difference
    EOGfeatures(i,19) = sum(delta(i,:).^2); %energy of difference
    %blinks left and right
%     EOGfeatures(i,20) = blinkdet(rawleft);
%     EOGfeatures(i,21) = blinkdet(rawright);
    
end
end
