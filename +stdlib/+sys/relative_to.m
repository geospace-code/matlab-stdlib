function r = relative_to(base, other)

r = "";

if ~stdlib.exists(base) || ~stdlib.exists(other)
  return
end

if ispc()
  cmd = sprintf('pwsh -c "Resolve-Path -Path ''%s'' -RelativeBasePath ''%s'' -Relative"', other, base);
else
  cmd = sprintf('realpath --relative-to="%s" "%s"', base, other);
end

[status, r] = system(cmd);
if status ~= 0
  warning("stdlib:relative_to:OSError", "Failed to compute relative path: %s", r);
end

r = string(strip(r));

if ispc()
  r = fullfile(stdlib.normalize(r));
end

end
