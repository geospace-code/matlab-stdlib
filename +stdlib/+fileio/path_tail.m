function last = path_tail(apath)

arguments
  apath string {mustBeScalarOrEmpty}
end

if strlength(apath) == 0
  last = "";
  return
end

[~, name, ext] = fileparts(stdlib.fileio.absolute_path(apath));

last = append(name, ext);

end
