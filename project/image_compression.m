% Set Image Path and Rank
imageFilePath = './otter.jpeg';
sv_num = 135;

% Get Image Info
img = imread(imageFilePath);
[img_size_x, img_size_y, channels] = size(img);
fprintf('image size: %dx%d, channel=%d\n', img_size_x, img_size_y, channels);
sv_total = sv(double(img(:,:,1)));
fprintf('singular value: %d/%d\n', sv_num, sv_total);
comp_ratio = (img_size_x * img_size_y) / (sv_num * (img_size_x + img_size_y + 1));
fprintf('compression ratio: %f', comp_ratio);

% Calculate the Low-Rank Approximation
layer = zeros(img_size_x, img_size_y, channels);
for i=1:channels
    layer = double(img(:,:,i));
    result = lr_approx(layer, sv_num);
    img(:,:,i) = uint8(result);
end
imshow(img);
title('');

% Get Amount of Non-Zero Singular Values
function result = sv(A)
    [~, S, ~] = svd(A);
    [result, ~] = size(find(diag(S) ~= 0));
end

% Low Rank Approximation
function result = lr_approx(A, sv_num)
    [m, n] = size(A);
    [U, S, V] = svd(A);
    V_conj = V';
    for rank=1:sv_num
        result = zeros([m, n]);
        for j=1:rank
            result = result + S(j,j) * U(:,j) * V_conj(j,:);
        end
    end
end