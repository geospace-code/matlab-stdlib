%% MATLABOLDERTHAN compare Matlab release name only e.g. R2025a
% this is to allow a basic version check back to R2016b at least

function isOlder = matlabOlderThan(release)

try
  isOlder = isMATLABReleaseOlderThan(release);
catch e
  if e.identifier ~= "MATLAB:UndefinedFunction"
    rethrow(e)
  end

  release = string(release);
  assert(isscalar(release) && strlength(release) == 6 && startsWith(release, "R"), "Release must be a string like 'R2025a'")

  curr = version('-release');
  release = extractAfter(release, 1);
  isOlder = curr < release;
end

end
