function [y, cmd] = is_mount(filepath)

cmd = '';
if ~stdlib.exists(filepath)
  y = false;
  return
end

if ispc()
  fs = {'/', filesep};
  if ismember(filepath, fs) || ...
      (endsWith(filepath, fs) && ...
       isfolder(filepath) && ...
       strcmp(filepath, stdlib.root(filepath)))
    y = true;
    return
  end
  cmd = sprintf('pwsh -c "(Get-Item -Path ''%s'').Attributes.ToString().Contains(''ReparsePoint'')"', filepath);
elseif ismac()
  if strcmp(filepath, '/')
    y = true;
    return
  end
  cmd = sprintf('[ $(stat -f %%d "%s") != $(stat -f %%d "%s") ]', ...
                filepath, stdlib.parent(filepath));
else
  cmd = sprintf('mountpoint -q "%s"', filepath);
end

[s, m] = system(cmd);

if ispc()
  y = s == 0 && strcmp(m, 'True');
else
  y = s == 0;
end


end
