% This program plot the relation between the number of selected singular values and the matrix norm

% Input image and define norm type
image_path = './result/result_compression_fruit_orig.png';
norm_type = 'fro';
norm_name = 'Frobenius norm';
[~,img_name,img_ext] = fileparts(image_path);
img = imread(image_path);

% Get matrix infos
[m,n,num_layers] = size(img);
sv_num = min(m,n);
errors = zeros(1,sv_num);

% SVD
orig_norm = norm(double(img), norm_type);
[U, S, V] = pagesvd(double(img), "econ");
V_conj = pagetranspose(V);

% Calculate the relative errors
result = zeros(m,n,num_layers);
for rank = 1:sv_num
    fprintf("Calculating rank = %03d...\n", rank);
    result = result + S(rank,rank,:) .* U(:,rank,:) .* V_conj(rank,:,:);
    errors(1,rank) = norm(double(result)-double(img), norm_type) / orig_norm;
end

% Plot the values
index_vector = 1:min(m,n);
plot(index_vector, errors(:), 'b-');
xlabel('Approximation Rank');
ylabel(['Relative Error (', norm_name, ')']);
grid on;