function RLocsInterval = findRRinterval(ECGseg, rows)

RLocsInterval = cell(rows, 1);

for i = 1:size(ECGseg, 1)

     [~,locs] = findpeaks(ECGseg(i,:),'MinPeakDistance',70);

    RLocsInterval{i} = diff(locs);
end
end
