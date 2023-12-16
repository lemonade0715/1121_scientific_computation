% stat.m
% This program plot the relation between the number of selected singular values and the matrix norm

% Input image and define norm type
image_path = './result/result_compression_fruit_orig.png';
norm_type = 'fro';
norm_name = 'Frobenius norm';
[~, img_name, img_ext] = fileparts(image_path);
img = imread(image_path);

% Get matrix infos
[m,n,num_layers] = size(img);
sv_num = min(m,n);
errors = zeros(1, sv_num);

% SVD
orig_norm = norm(double(img), norm_type);
[U, S, V] = pagesvd(double(img), "econ");
V_conj = pagetranspose(V);

% Calculate the relative errors
result = zeros(m, n, num_layers);
for rank = 1:sv_num
    fprintf("Calculating rank = %d...\n", rank);
    result = result + S(rank,rank,:) .* U(:,rank,:) .* V_conj(rank,:,:);
    errors(1,rank) = norm(double(result)-double(img), norm_type) / orig_norm;
end

% Plot the values
index_vector = 1:min(m,n);
figure;
plot(index_vector, errors(:), 'b-');
xlabel('Approximation Rank');
ylabel(['Relative Error (', norm_name, ')']);
grid on;
print(gcf, 'stat1.png', '-dpng', '-r1000', '-image');
figure;
plot(index_vector, diag(S(:,:,1)) ./ S(1,1,1), 'r-', index_vector, diag(S(:,:,2)) ./ S(1,1,2), 'g-', index_vector, diag(S(:,:,3)) ./ S(1,1,3), 'b-');
xlabel('Approximation Rank');
ylabel('Singular Value (Relative)');
print(gcf, 'stat2.png', '-dpng', '-r1000', '-image');