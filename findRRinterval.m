function RLocsInterval = findRRinterval(ECGseg, rows)

RLocsInterval = cell(rows, 1);

for i = 1:size(ECGseg, 1)

%     [~,locs] = findpeaks(ECGseg(i,:),'MinPeakHeight',0.09,...
%               'MinPeakDistance',60);
     [~,locs] = findpeaks(ECGseg(i,:));

    RLocsInterval{i} = diff(locs);
end
end