function t = serial_example

t0 = tic;
A = 500; 
a = zeros(100);
fileID = fopen('time.txt','w');
for i = 1:100
    a(i) = max(abs(eig(rand(A))));
    fprintf(fileID,'hello matlab\n');
end
t = toc(t0);
fclose(fileID);
end
