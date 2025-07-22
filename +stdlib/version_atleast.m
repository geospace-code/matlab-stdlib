%% VERSION_ATLEAST compare two string verions: major.minor.rev.patch
% compare two string verions: major.minor.rev.patch
% numeric portions only.
%
%% Inputs
% * in: version to examine (string)
% * ref: version to compare against (at least this version is true)
%% Outputs
% * r: logical

function r = version_atleast(in, ref)
arguments
  in {mustBeTextScalar}
  ref {mustBeTextScalar}
end


if stdlib.isoctave()
  r = compare_versions(in, ref, '>=');
  return
end

parts1 = str2double(strsplit(in, '.'));
parts2 = str2double(strsplit(ref, '.'));

r = true;

for i = 1:min(length(parts1), length(parts2))
  if parts1(i) < parts2(i)
    r = false;
    return
  elseif parts1(i) > parts2(i)
    return
  end
end

% If all common parts are equal, check for longer versions
% If "ref" is longer and its remaining parts are not all zeros, then "in" is less.
if length(parts1) < length(parts2)
  if any(parts2(length(parts1)+1:end) > 0)
    r = false;
  end
end

end

%!assert(version_atleast("1.2.3", "1.2"))
%!assert(version_atleast("20.11a", "20.3b"))
