function t = parallel_example_slurm(n)

t0 = tic;
A = 500;
a = zeros(n);

parfor i = 1:n
  a(i) = max(abs(eig(rand(A))));
end

t = toc(t0);
save prueba.txt t -ascii

end
