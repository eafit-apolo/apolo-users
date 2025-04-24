%==========================================================
% MATLAB job submission script: matlab_batch.m
%==========================================================

workers = str2num(getenv('SLURM_NTASKS'));
c = parcluster('apolo');
c.AdditionalProperties.TimeLimit = '1:00:00';
c.AdditionalProperties.Partition = 'longjobs';
j = c.batch(@parallel_example_slurm, 1, {1000}, 'pool', workers);
exit;
