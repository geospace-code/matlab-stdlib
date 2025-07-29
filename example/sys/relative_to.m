%% SYS.RELATIVE_TO get relative path to other from base
%
% this works but is slow

function r = relative_to(base, other)

r = "";

if ~stdlib.exists(base) || ~stdlib.exists(other)
  return
end

if ispc()
  cmd = sprintf('pwsh -c "Resolve-Path -Path ''%s'' -RelativeBasePath ''%s'' -Relative"', other, base);
elseif ismac()
  cmd = sprintf('grealpath --relative-to="%s" "%s"', base, other);
else
  cmd = sprintf('realpath --relative-to="%s" "%s"', base, other);
end

[status, r] = system(cmd);
if status ~= 0
  warning("stdlib:relative_to:OSError", "Failed to compute relative path: %s", r);
end

r = string(strip(r));

if ispc()
  r = stdlib.normalize(r);
end

end
