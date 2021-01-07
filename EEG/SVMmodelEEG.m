function [knownStages, predictions_test, testingDataSave] = SVMmodelEEG(EEGfeatures, stages, nSamples, kernel, fileName)

%Create xlsx file for the result
writecell({'Recording', 'Training accuracy', 'Testing accuracy'} ,fileName);

results = zeros(10, 2);
predictions_test = zeros(350, 10);
knownStages = zeros(370, 10);
testingDataSave = zeros(350, 10);
    
for R = 1:10 %10 recordings
    features = [EEGfeatures stages(:, 1)]; %add stages next to hrv features
    features = features(getindexrange(nSamples, R), :); %get features with same range as recording

    % Split data, 70% training data and 30% testing data 
    trainingRatio = 0.7;
    trainingData = [];
    testingData = [];
    
    %Stratified sampling
    for i = 1:6 %6 stages
        ithClassInd = find(features(:, end) == i-1); 
        nithClass = ceil(size(ithClassInd, 1)*trainingRatio);
        trainingData = [trainingData; features(ithClassInd(1:nithClass), :)];
        testingData = [testingData; features(ithClassInd(nithClass+1:end), :)];
    end
    
    l_test = length(testingData);
    testD = [testingData(:,1); zeros(350-l_test, 1)];
    testingDataSave(:,R) = testD; 

    %Create model 
    SVMModel = trainSVM(trainingData(:, 1:end-1), ...
        trainingData(:, end), kernel);
    
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
    known = testingData(:,12); %for EEG
    known = [known; zeros(370-l_data, 1)];
    knownStages(:,R) = known;
        
end

%Save result in the xlsx file
writecell({'R1', 'R2', 'R3', 'R4', 'R5', 'R6', 'R7', 'R8', 'R9', 'R10'}',...
    fileName,'Range','A2');
writematrix(results ,fileName,'Range','B2');
end
