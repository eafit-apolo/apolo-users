function t = serial_example(n)

t0 = tic;
A = 500;
a = zeros(n);

for i = 1:n
    a(i) = max(abs(eig(rand(A))));
end

t = toc(t0);

end
