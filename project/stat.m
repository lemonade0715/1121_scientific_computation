% This program plot the relation between the number of selected singular values and the matrix norm

% Input image and define norm type
image_path = './otter.jpeg';
norm_type = inf;
norm_name = 'Infinity norm';
[~,img_name,img_ext] = fileparts(image_path);
img = imread(image_path);

% Get matrix infos
[m,n,num_layers] = size(img);
sv_num = min(m,n);
norms = zeros([1,sv_num,num_layers]);

% Compute the SVD
for layer=1:num_layers
    % Find the SVD of current layer
    A = double(img(:,:,layer));
    [U, S, V] = svd(A,"econ");
    V_conj = V';
    for rank=1:sv_num
        result = zeros([m,n]);
        for i=1:rank
            result = result + S(i,i) * U(:,i) * V_conj(i,:);
            norms(1,rank,layer) = norm(A-result, norm_type);
        end
        disp(['layer=',num2str(layer),', rank=',num2str(rank)]);
    end
end

% Plot the values
index_vector = 1:min(m,n);
plot(index_vector, norms(:,:,1), 'r-', index_vector, norms(:,:,2), 'g-', index_vector, norms(:,:,3), 'b-');
title(['LRA of ',img_name,img_ext]);
xlabel('Approximation Rank');
ylabel(norm_name);
grid on;