function expanded = expanduser(p)

arguments
  p string {mustBeScalarOrEmpty}
end

expanded = p;

if ~startsWith(expanded, "~")
  return
end

home = stdlib.fileio.homedir();

if ~isempty(home)
  expanded = fullfile(home, extractAfter(expanded, 1));
end

end %function
