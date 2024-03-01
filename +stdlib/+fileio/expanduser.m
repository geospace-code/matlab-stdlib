function e = expanduser(p)

arguments
  p (1,1) string
end

e = p;

if ~all(startsWith(e, "~")) || (all(strlength(e) > 1) && ~all(startsWith(e, "~/")))
  return
end

home = stdlib.fileio.homedir();

if ~isempty(home)
  e = stdlib.fileio.join(home, extractAfter(e, 1));
end

end %function
