function [knownStages, predictions_test, testAcc, trainAcc] = SVMmodel(hrv, stages, nSamples)

%Create xlsx file for the result
filename = 'SVM_result.xlsx';
writecell({'Recording', 'Training accuracy', 'Testing accuracy'} ,filename);

results = zeros(5, 2);
predictions_test = zeros(350, 5);
knownStages = zeros(370, 5);
    
for R = 1:5 %5 recordings
    features = [hrv stages(:, 1)]; %add stages next to hrv features
    features = features(getindexrange(nSamples, R), :); %get features with same range as recording

    % Split data, 70% training data and 30% testing data 
    trainingRatio = 0.7;
    trainingData = [];
    testingData = [];
    
    %Stratified sampling
    for i = 1:5 %5 stages
        ithClassInd = find(features(:, end) == i); 
        nithClass = ceil(size(ithClassInd, 1)*trainingRatio);
        trainingData = [trainingData; features(ithClassInd(1:nithClass), :)];
        testingData = [testingData; features(ithClassInd(nithClass+1:end), :)];
    end

    %Create model 
    SVMModel = trainSVM(trainingData(:, 1:end-1), ...
        trainingData(:, end), 'linear');
    
    %Train the model
    predicted_train = predict(SVMModel, trainingData(:, 1:end-1));
    trainAcc = sum(trainingData(:, end) == predicted_train) / length(trainingData(:, end)) * 100;
    
    %Test the model
    predicted_test = predict(SVMModel, testingData(:, 1:end-1));
    testAcc = sum(testingData(:, end) == predicted_test) / length(testingData(:, end)) * 100;
    
    l_test = length(predicted_test);
    predicted_test = [predicted_test; zeros(350-l_test, 1)];
    predictions_test(:,R) = predicted_test; 
    
    %Save the accuracy values as results
    results(R, 1) = trainAcc;
    results(R, 2) = testAcc;
    
    %Variables for the confusion matrix
    l_data = height(testingData);
    known = testingData(:,19);
    known = [known; zeros(370-l_data, 1)];
    knownStages(:,R) = known;
        
end

%Save result in the xlsx file
writecell({'R1', 'R2', 'R3', 'R4', 'R5'}' ,filename,'Range','A2');
writematrix(results ,filename,'Range','B2');

end
