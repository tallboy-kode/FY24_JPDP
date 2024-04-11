close all;
clc;

% File name.
fileName1 = 'output_data.txt';
%fileName1 = 'fir_B_coeffs.txt';


%Sample rate.
fs = 96000;

fileName = fileName1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create a file object and open it with read permissions only.
file = fopen(fileName, 'rt');

% Loop through length of file.
zeropad_multiple = 4;
filterOutputSamples = zeros(1, 3316*zeropad_multiple);
sampleCount = 1;

sample = fgetl(file)';
while ischar(sample)
    filterOutputSamples(1, sampleCount) = str2double(sample);
    sampleCount = sampleCount + 1;
    sample = fgetl(file)';
end
fclose(file);

freq = fft(filterOutputSamples);
freq = freq(1,1:length(filterOutputSamples)/2 + 1);
absFreq = abs(freq);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
logAbsFreq_A = 20*log10(absFreq);


% Plot the Filter Output samples.
adcTime = linspace(0,length(filterOutputSamples)-1, length(filterOutputSamples));
fAxis = linspace(0, fs/2, length(absFreq));

figure('Name','FIR_B Time Output');                
subplot(2,1,1);
plot(adcTime, filterOutputSamples,"Marker",".");
xlabel('Sample #');
ylabel('Amplitude');

%figure('Name','FIR_B Output Spectrum');                
subplot(2,1,2);
plot(fAxis, logAbsFreq_A, "Marker", ".");
xlabel('Freq (Hz)');
ylabel('dB');


