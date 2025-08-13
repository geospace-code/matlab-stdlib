%% MATLABOLDERTHAN compare Matlab release name only e.g. R2025a
% works back to Matlab R2011b at least

function isOlder = matlabOlderThan(release)

try
  isOlder = isMATLABReleaseOlderThan(release);
catch e
  if ~strcmp(e.identifier, 'MATLAB:UndefinedFunction')
    rethrow(e)
  end

  r = char(release);
  assert(length(r) == 6 && r(1) == 'R', 'Release must be a string like ''R2025a''')

  curr = version('-release');
  nc = str2double(curr(1:4));
  nv = str2double(r(2:5));
  if nc == nv
    isOlder = curr(5) < r(6);
  else
    isOlder = nc < nv;
  end
end

end
