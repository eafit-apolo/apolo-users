% Number of simulations
numSims = 10;
W=zeros(1,numSims);

% Enter to parsim_test.xls path
cd /home/mgomezzul/tests/matlab/slurm

% Create an array of SimulationInput objects and specify the argument value
% for each simulation.
for x = 1:numSims
	  simIn(x) = Simulink.SimulationInput('parsim_test');
simIn(x) = setBlockParameter(simIn(x), 'parsim_test/Transfer Fcn', 'Denominator', num2str(x));
end

% Simulate the model.
simOut = parsim(simIn);

for x = 1:numSims
	  W(1,x)= max(simOut(x).get('y'));
end

% plot(W)
save('/home/mgomezzul/output_file.mat','W');
