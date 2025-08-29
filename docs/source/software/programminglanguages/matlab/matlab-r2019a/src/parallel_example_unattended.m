p = parpool(str2num(getenv('SLURM_NTASKS')));

t0 = tic;
A = 500;
a = zeros(1000);
parfor i = 1:1000
  a(i) = max(abs(eig(rand(A))));
end
t = toc(t0)
exit
