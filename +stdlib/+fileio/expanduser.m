function expanded = expanduser(p)

arguments
  p string
end

expanded = p;

if ispc
  home = getenv('USERPROFILE');
else
  home = getenv('HOME');
end

if ~isempty(home)
  i = startsWith(expanded, "~");
  expanded(i) = fullfile(home, extractAfter(expanded(i), 1));
end

end %function
