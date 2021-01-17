function peak2 = blinkdet(eogsignal)

peak=zeros([1 length(eogsignal)]);
%median filter
fs=125;
y=medfilt1(eogsignal);
%add zeros to signal to avoid loosing possible blinks

%bandpass filter
z=bandpass(y,[1.5 8],fs);

%square output and apply moving average filter
z2=z.^2;
z3=movmean(z2,20);

%first derivative and MA filter
z4=diff(z3);
z5=movmean(z4,20);

%blink detection algorithm
for i=1:length(z3)
    if sign(z5(i)) > sign(z5(i+1))
        if z5(i)-z5(i+1) > (0.5/60^2)*z3(i)
            if z3(i) > 0.2
            peak(1,i)=1;
            end
        end
    end
end 
peak2=arrangeDataECG(peak);

end

