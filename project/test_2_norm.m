% This program shows that calculating 2-norm of a matrix takes much more time than others
A = rand(10000,10000);
norm_type_enum = {'fro', 1, 2, inf};
norm_name_enum = {'Frobenius ', '1-', '2-', 'Infinity '};

for i=1:length(norm_type_enum)
    tic;
    norm(A, norm_type_enum{i});
    elapsed_time = toc;
    disp(['[', norm_name_enum{i}, 'Norm]']);
    disp(['Elapsed Time: ', num2str(elapsed_time), '(sec.)']);
end