close all;
clc;

%Generate a white gaussian noise output file
fileName_noise = 'input_data_noise.txt';
fp_noise = fopen(fileName_noise, 'w');
data_noise = randn(1,3316)/3316;
[nrows, ncols] = size(data_noise);
for row = 1:ncols
    fprintf(fp_noise, '%f\n', data_noise(row));
end
fclose(fp_noise);

%Generate a impulse file
fileName_impulse = 'input_data_impulse.txt';
fp_impulse = fopen(fileName_impulse, 'w');
data_impulse = zeros(1,3316);
data_impulse(10) = 1.0;
[nrows, ncols] = size(data_impulse);
for row = 1:ncols
    fprintf(fp_impulse, '%f\n', data_impulse(row));
end
fclose(fp_impulse);

%Generate a sinewave file
fs1 = 17241;
fs2 = 35000;
SampleFreq = 96000;
fileName_sine = 'input_data_sine.txt';
fp_sine = fopen(fileName_sine, 'w');
data_sine = zeros(1,3316);
[nrows, ncols] = size(data_sine);
for row = 1:ncols
    fprintf(fp_sine, '%f\n', (sin(2*pi()*row*fs1/SampleFreq) + sin(2*pi()*row*fs2/SampleFreq))/3316);
end
fclose(fp_sine);
