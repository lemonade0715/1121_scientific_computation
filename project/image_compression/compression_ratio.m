% compression_ratio.m

% Set image path and get info
imageFilePath = './result/result_compression_fruit_orig.png';
info = imfinfo(imageFilePath);
img_size = [info.Height, info.Width];
max_sv = max(img_size);

% Calculate the compression ratios
compression_ratios = zeros(1, max_sv, "double");
temp = img_size(1) * img_size(2) / (img_size(1) + img_size(2) + 1);
for i = 1:max_sv
    compression_ratios(i) = temp / i;
end

% Plot the result
index_vector = 1:max_sv;
plot(index_vector, compression_ratios, 'b-');
xlabel('Approximation Rank');
ylabel('Compression Ratio');
grid on;

print(gcf, 'compression_ratio.png', '-dpng', '-r1000', '-image');
