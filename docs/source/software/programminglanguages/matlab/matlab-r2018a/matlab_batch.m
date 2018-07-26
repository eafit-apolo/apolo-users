%==========================================================
% MATLAB job submission script: matlab_batch.m
%==========================================================

c = parcluster('apolo');
c.AdditionalProperties.TimeLimit = '1:00:00';
c.AdditionalProperties.Partition = 'longjobs'; 
j = c.batch(@parallel_example, 1, {1000}, 'pool', 8);
exit;
