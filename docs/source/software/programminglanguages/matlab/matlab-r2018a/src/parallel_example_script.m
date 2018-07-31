n = 1000;
t0 = tic;
A = 500; 
a = zeros(n);

parfor i = 1:n
  a(i) = max(abs(eig(rand(A))));
end

t = toc(t0);
