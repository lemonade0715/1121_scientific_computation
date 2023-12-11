% audio.m

% Read Audio Files (Audio Matrix, Sample Rate)
[audio_org, sr_org] = audioread("./music_segment.wav");
[audio_noised, sr_noised] = audioread("./music_segment_with_white_noise.wav");


% Step 2: Apply SVD to decompose the audio matrix
[U, S, V] = svd(audio_org, 'econ');

% Step 3: Modify the singular values to reduce noise
% You may want to experiment with different thresholds or methods
% to determine how many singular values to keep for noise reduction.
% For example, keeping only the first N singular values:
N = 100; % Adjust as needed
S_reduced = S;
S_reduced(N+1:end, :) = 0;

% Step 4: Reconstruct the modified matrix
audio_reduced = U * S_reduced * V';

% Step 5: Export the noise-reduced version as a WAV file
output_filename = 'noise_reduced_audio.wav';
audiowrite(output_filename, audio_reduced, fs);

