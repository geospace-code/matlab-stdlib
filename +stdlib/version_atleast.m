%% VERSION_ATLEAST compare two string verions: major.minor.rev.patch
% compare two string verions: major.minor.rev.patch
% uses strings to compare so mixed number/string is OK
%
%% Inputs
% * in: version to examine (string)
% * ref: version to compare against (at least this version is true)
%% Outputs
% * r: logical

function r = version_atleast(in, ref)
% arguments
%   in (1,1) string
%   ref (1,1) string
% end

if stdlib.isoctave()
  r = compare_versions(in, ref, '>=');
  return
end

in = split(in, ' ');
in = split(in(1), '.');

ref = split(ref, '.');

for i = 1:min(length(in), length(ref))
  if in(i) > ref(i)
    r = true;
    return
  elseif in(i) < ref(i)
    r = false;
    return
  end
end

r = in(end) >= ref(end);

end

%!assert(version_atleast("1.2.3", "1.2"))
