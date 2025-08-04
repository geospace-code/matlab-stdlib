function y = is_mount(filepath)


if ispc()
  if any(ismember(filepath, ["/", "\"])) || ...
      (endsWith(filepath, ["/", "\"]) && isfolder(filepath) && filepath == stdlib.root(filepath))
    y = true; 
    return
  end
  cmd = strcat('pwsh -c "(Get-Item -Path ''', filepath, ''').Attributes.ToString().Contains(''ReparsePoint'')"');
elseif ismac()
  if filepath == "/"
    y = true;
    return
  end
  cmd = "[ $(stat -f %d " + filepath + ") != $(stat -f %d " + stdlib.parent(filepath) + ")]";
else
  cmd = "mountpoint -q " + filepath;
end

[s, m] = system(cmd);

if ispc()
  y = s == 0 && m == "True";
else 
  y = s == 0;
end


end
