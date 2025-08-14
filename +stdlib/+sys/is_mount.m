function y = is_mount(filepath)

y = logical.empty;
if ~stdlib.exists(filepath), return, end

if ispc()
  if any(ismember(filepath, ["/", "\"])) || ...
      (endsWith(filepath, "/" | filesep) && isfolder(filepath) && filepath == stdlib.root(filepath))
    y = true;
    return
  end
  cmd = sprintf('pwsh -c "(Get-Item -Path ''%s'').Attributes.ToString().Contains(''ReparsePoint'')"', filepath);
elseif ismac()
  if filepath == "/"
    y = true;
    return
  end
  cmd = sprintf('[ $(stat -f %%d "%s") != $(stat -f %%d "%s")]', ...
                filepath, stdlib.parent(filepath));
else
  cmd = sprintf('mountpoint -q "%s"', filepath);
end

[s, m] = system(cmd);

if ispc()
  y = s == 0 && m == "True";
else
  y = s == 0;
end


end
