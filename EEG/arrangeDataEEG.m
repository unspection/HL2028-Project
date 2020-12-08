function [R_Epoch, Alpha, Beta, Theta, Delta, Gamma] = arrangeDataEEG(filtered_EEG, Alpha, Beta, Theta, Delta, Gamma)

R_Epoch = reshape(filtered_EEG, 3750 ,[]);
R_Epoch = R_Epoch';
R_Epoch(end, :) = [];
Alpha = reshape(Alpha, 3750, []);
Alpha = Alpha';
Alpha(end, :) = [];
Beta = reshape(Beta, 3750, []);
Beta = Beta';
Beta(end, :) = [];
Theta = reshape(Theta, 3750, []);
Theta = Theta';
Theta(end, :) = [];
Delta = reshape(Delta, 3750, []);
Delta = Delta';
Delta(end, :) = [];
Gamma = reshape(Gamma, 3750, []);
Gamma = Gamma';
Gamma(end, :) = [];

end
