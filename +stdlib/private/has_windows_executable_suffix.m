function i = has_windows_executable_suffix(file)

pec = getenv('PATHEXT');
if isempty(pec)
  pec = '.COM;.EXE;.BAT;.CMD;';
end
pe = split(string(pec), pathsep);

i = endsWith(stdlib.suffix(file), pe, 'IgnoreCase', true);

end
