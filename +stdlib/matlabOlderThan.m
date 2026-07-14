%% MATLABOLDERTHAN compare Matlab release name only e.g. R2025a
% works for Matlab >= R2020b
%
% our implementation is about 10x faster than isMATLABReleaseOlderThan(release)
% it takes about twice as long as using char() manipulations, but much
% clearer.

function y = matlabOlderThan(r)
arguments
  r {mustBeTextScalar}
end


assert(strlength(r) == 6 && startsWith(r, 'R'), 'Matlab release must be like ''R2025a''')

y = matlabRelease().Release < r;


end
