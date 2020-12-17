function new_confusionMatrix(knownStages, predictedStages)

C = confusionchart(knownStages, predictedStages, 'RowSummary','row-normalized','ColumnSummary','column-normalized');
C.Title = sprintf('Confusion matrix');

end