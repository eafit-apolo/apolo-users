function toc = paralell_example(n)

tic
n = 1000;
A = 500; 
a = zeros(n);
parfor i = 1:n
  a(i) = max(abs(eig(rand(A))));
end
toc
