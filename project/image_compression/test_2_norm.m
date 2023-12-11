% This program shows that calculating 2-norm of a matrix takes much more time than others
norm_type_enum = {'fro', 1, 2, inf};
norm_name_enum = {'Frobenius ', '1-', '2-', 'Infinity '};
init = 100;
samples = 10;
stats = zeros(4,samples);

for i=1:length(norm_name_enum)
    for j=1:samples
        fprintf("sample=%d\n",j);
        A = rand(init*j,init*j);
        tic;
        norm(A, norm_type_enum{i});
        stats(i,j) = toc;
    end
end
disp(stats);

% Plot the values
index_vector = init:init:init*samples;
plot(index_vector, stats(1,:), 'r-', index_vector, stats(2,:), 'g-', index_vector, stats(3,:), 'b-', index_vector, stats(4,:), 'c-');
title('Runtime of Matrix Norms');
xlabel('Random Matrix Size');
ylabel('(sec)');
grid on;