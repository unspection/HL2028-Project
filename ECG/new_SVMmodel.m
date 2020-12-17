function [knownStages, predictedStages, testAcc, trainAcc] = new_SVMmodel(hrv, stages, kernel, fileName)

%Create xlsx file for the result
writecell({'Training accuracy', 'Testing accuracy'} ,fileName);

results = zeros(1, 2);
features = [hrv stages(:, 1)]; 

%Random sampling
%Cross varidation (train: 70%, test: 30%)
% cv = cvpartition(size(features,1),'HoldOut',0.3);
% idx = cv.test;
% % Separate to training and test data
% trainingData = features(~idx,:);
% testingData  = features(idx,:);

%Stratified sampling 
trainingRatio = 0.7;
trainingData = [];
testingData = [];
    
for i = 1:6 %6 stages
    ithClassInd = find(features(:, end) == i-1); 
    nithClass = ceil(size(ithClassInd, 1)*trainingRatio);
    trainingData = [trainingData; features(ithClassInd(1:nithClass), :)];    
    testingData = [testingData; features(ithClassInd(ithClassInd+1:end), :)];
end

%Create model 
SVMModel = trainSVM(trainingData(:, 1:end-1), trainingData(:, end), kernel);
    
%Train the model
predicted_train = predict(SVMModel, trainingData(:, 1:end-1));
trainAcc = sum(trainingData(:, end) == predicted_train) / length(trainingData(:, end)) * 100;

%Test the model
predictedStages = predict(SVMModel, testingData(:, 1:end-1));
testAcc = sum(testingData(:, end) == predictedStages) / length(testingData(:, end)) * 100;
    
%Save the accuracy values as results
results(1, 1) = trainAcc;
results(1, 2) = testAcc;
    
knownStages = testingData(:,19); 
       
%Save result in the xlsx file
writematrix(results ,fileName,'Range','A2');

end
