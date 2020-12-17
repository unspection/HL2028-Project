function confusionMatrix(knownStages, record, predictedStages)

s = knownStages(:,record);
s = s(1:length(predictedStages));

C = confusionchart(s, predictedStages, 'RowSummary','row-normalized','ColumnSummary','column-normalized');
C.Title = sprintf('Confusion matrix for R%d', record);

saveas(C, sprintf('confusionMatrixR%d.png',record))

end
