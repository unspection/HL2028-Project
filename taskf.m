function [] = taskf(xmlfile,hrv)


[~, stages, ~,~] = readXML(xmlfile);

%find mode
for i=1:(length(stages)/30)
    mode30sec(i) = mode(stages(1,(1+(i-1)*30):(i*30)));
end
[f,g]=size(mode30sec);
mode30sec(1,g+1) = 5;
[m,n]=size(hrv);

all_stages = mode30sec;

stages_awake = [mode30sec == 5];
stages_N1 = [mode30sec == 4];
stages_N2 = [mode30sec == 3];
stages_N3 = [mode30sec == 2];
stages_N4 = [mode30sec == 1];
stages_REM = [mode30sec == 0];

for i=1:n
    temp=corrcoef(stages_awake,hrv(:,i));
    c(1,i) = temp(1,2);
    temp=corrcoef(stages_N1,hrv(:,i));
    c(2,i) = temp(1,2);
    temp=corrcoef(stages_N2,hrv(:,i));
    c(3,i) = temp(1,2);
    temp=corrcoef(stages_N3,hrv(:,i));
    c(4,i) = temp(1,2);
    temp=corrcoef(stages_N4,hrv(:,i));
    c(5,i) = temp(1,2);
    temp=corrcoef(stages_REM,hrv(:,i));
    c(6,i) = temp(1,2);
    temp=corrcoef(all_stages,hrv(:,i));
    c(7,i) = temp(1,2);
    i=i+1;
end

imagesc(c')
colorbar
end

