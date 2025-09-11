function i = has_windows_executable_suffix(p)
arguments
  p string
end

pec = getenv("PATHEXT");
if isempty(pec)
  pec = '.COM;.EXE;.BAT;.CMD;';
end
pe = split(string(pec), pathsep);

i = endsWith(stdlib.suffix(p), pe, IgnoreCase=true);

end
