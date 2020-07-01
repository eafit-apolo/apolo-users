% Example running a Simulink model.

% The Simulink model is called |parsim_test.slx| and it *must be* in
% the cluster.

% Number of simulations
numSims = 10;
W = zeros(1,numSims);

% Changing to the |parsim_test.slx| path
cd ~/tests/simulink

% Create an array of |SimulationInput| objects and specify the argument value
% for each simulation. The variable |x| is the input variable in the Simulink
% model.
for x = 1:numSims
  simIn(x) = Simulink.SimulationInput('parsim_test');
  simIn(x) = setBlockParameter(simIn(x), 'parsim_test/Transfer Fcn', 'Denominator', num2str(x));
end

% Running the simulations.
simOut = parsim(simIn);

% The variable |y| is the output variable in the Simulink model.
for x = 1:numSims
  W(1,x) = max(simOut(x).get('y'));
end

save('~/output_file.mat','W');
