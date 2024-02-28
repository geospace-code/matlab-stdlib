function e = expanduser(p)

arguments
  p string {mustBeScalarOrEmpty}
end

e = p;

if ~all(startsWith(e, "~")) || (all(strlength(e) > 1) && ~all(startsWith(e, "~/")))
  return
end

home = stdlib.fileio.homedir();

if ~isempty(home)
  e = fullfile(home, extractAfter(e, 1));
end

end %function
