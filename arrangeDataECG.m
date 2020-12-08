function epoch_R1 = arrangeDataECG(preprocessed_R)

epoch_R1 = reshape(preprocessed_R, 3750, []);
epoch_R1 = epoch_R1';
epoch_R1(end,:) = [];

end