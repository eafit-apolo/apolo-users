n = 1000;
t0 = tic;
A = 500;
a = zeros(n);
fileID = fopen('/tmp/time.txt','wt');

parfor i = 1:n
  a(i) = max(abs(eig(rand(A))));
end

t = toc(t0);
fprintf(fileID, '%6.4f\n', t);
fclose(fileID);
