%% MATLABOLDERTHAN compare Matlab release name only e.g. R2025a
% works for Matlab >= R2016b
%
% our simpler checks is about 200x faster than isMATLABReleaseOlderThan(release)

function isOlder = matlabOlderThan(release)
assert(nargin == 1, 'Specify Matlab release like ''R2025a''')

% converting to char about 2x fast as extract*() on string()
% length on char 10+% faster than strlength(string())
r = char(release);
assert(length(r) == 6 && r(1) == 'R', 'Matlab release must be like ''R2025a''')

curr = version('-release');
if isempty(curr)
  isOlder = true;
  return
end

if strcmp(curr(1:4), r(2:5))
  isOlder = curr(5) < r(6);
else
  % string() lessThan comparison about same speed as str2double()
  nc = str2double(curr(1:4));
  nv = str2double(r(2:5));
  isOlder = nc < nv;
end

end
