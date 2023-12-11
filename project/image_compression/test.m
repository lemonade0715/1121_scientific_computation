C = zeros(10000,10000,3);
for i=1:3
    A = rand(10000,1);
    B = rand(1,10000);
    C(:,:,i) = A * B;
end
imshow(C);