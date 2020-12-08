function saveFeaturesEEG(EEGfeatures, fileName)

R1 = sym('R1_', [1083 1]);
R2 = sym('R2_', [1078 1]);
R3 = sym('R3_', [1048 1]);
R4 = sym('R4_', [874 1]);
R5 = sym('R5_', [1083 1]);
R = [R1;R2;R3;R4;R5];
R = arrayfun(@char, R, 'uniform', 0);


writecell({'Recording', 'RMS', 'VAR', 'SD', 'Kurtosis', 'Skewness',...
    'ApEn', 'SPS Alpha', 'SPS Beta', 'SPS Theta', 'SPS Delta',...
    'SPS Gamma' } ,fileName);
writecell(R, fileName,'Range','A2');
writematrix(EEGfeatures, fileName,'Range','B2');


end
