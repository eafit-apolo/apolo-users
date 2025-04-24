t0 = tic;
A = 500;
a = zeros(100);
fileID = fopen('/home/mgomezzul/time.txt','wt');
for i = 1:100
    a(i) = max(abs(eig(rand(A))));
end
t = toc(t0);
fprintf(fileID, '%6.4f\n', t);
fclose(fileID);
