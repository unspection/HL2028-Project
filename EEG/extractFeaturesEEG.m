function NEWfeatures = extractFeaturesEEG(R_Epoch, alpha, beta, theta, delta, gamma)

nSamples = size(R_Epoch, 1);
NEWfeatures = zeros(nSamples, 11);

for i = 1:nSamples
    
    %Time domain
    NEWfeatures(i, 1) = rms(R_Epoch(i,:));
    NEWfeatures(i, 2) = var(R_Epoch(i,:)); 
    NEWfeatures(i, 3) = std(R_Epoch(i,:));
    NEWfeatures(i, 4) = kurtosis(R_Epoch(i,:));
    NEWfeatures(i, 5) = skewness(R_Epoch(i,:));
    NEWfeatures(i, 6) = approximateEntropy(R_Epoch(i,:));
    
    %Frequency domain
    %Square of the Power Spectrum
    s = sum(alpha(i,:));
    NEWfeatures(i, 7) = s.^2; 
    s = sum(beta(i,:));
    NEWfeatures(i, 8) = s.^2;
    s = sum(theta(i,:));
    NEWfeatures(i, 9) = s.^2;
    s = sum(delta(i,:));
    NEWfeatures(i, 10) = s.^2;
    s = sum(gamma(i,:));
    NEWfeatures(i, 11) = s.^2;
    
end
