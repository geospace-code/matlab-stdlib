function exe = perl_exe()

persistent perle

if ~isempty(perle)
  exe = perle;
  return
end

cwd = fileparts(mfilename("fullpath"));

[r, s] = perl(cwd + "/private/executable.pl");

if s == 0 && isfile(r)
  exe = r;
  perle = r;
end

end