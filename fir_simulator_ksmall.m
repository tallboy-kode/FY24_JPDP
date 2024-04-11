close all;
clc;

%Select desired input file - Only select one at a time
%fileName_DataIn = 'input_data_noise.txt';
% fileName_DataIn = 'input_data_impulse.txt';    %use this one to show you
%the shape of the filter
fileName_DataIn = 'input_data_sine.txt';


%Read input data
fp_DataIn = fopen(fileName_DataIn, 'rt');
% Loop through length of file.
data_in = zeros(1, 3316);
dataIdx = 1;
sample = fgetl(fp_DataIn)';
while ischar(sample)
    data_in(1, dataIdx) = str2double(sample);
    dataIdx = dataIdx + 1;
    sample = fgetl(fp_DataIn)';
end
fclose(fp_DataIn);

%Read Filter Coefficients
fileName_Coeffs = 'fir_B_coeffs.txt';
fp_Coeffs = fopen(fileName_Coeffs, 'rt');
% Loop through length of file.
coeffs = zeros(1, 35);
dataIdx = 1;
sample = fgetl(fp_Coeffs)';
while ischar(sample)
    coeffs(1, dataIdx) = str2double(sample);
    dataIdx = dataIdx + 1;
    sample = fgetl(fp_Coeffs)';
end
fclose(fp_Coeffs);


%Filter the data
zeropad_multiple = 4;
zeropad = zeros(1, 3316*(zeropad_multiple-1));
data_out = filter(coeffs, 1, data_in);
data_out = cat(2, data_out, zeropad);

%Create output freq spectrum
freq = fft(data_out);
freq = freq(1,1:length(data_out)/2 + 1);
absFreq = abs(freq);
logAbsFreq_A = 20*log10(absFreq);


% Plot the filter output time samples and its spectrum.
fs = 96000;
sampleCount = linspace(0,length(data_out)-1, length(data_out));
fAxis = linspace(0, fs/2, length(absFreq));

figure('Name','FIR_B Time Output');                
subplot(2,1,1);
plot(sampleCount, data_out,"Marker",".");
xlabel('Sample #');
ylabel('Amplitude');

%figure('Name','FIR_B Output Spectrum');                
subplot(2,1,2);
plot(fAxis, logAbsFreq_A, 'r');
xlabel('Freq (Hz)');
ylabel('dB');


