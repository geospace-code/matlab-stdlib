function exists = h5exists(file, variable)

arguments
  file (1,1) string {mustBeFile}
  variable string {mustBeScalarOrEmpty}
end

exists = false;

if(strlength(variable) == 0)
  return
end

if ~startsWith(variable, "/")
  variable = "/" + variable;
end

try
  h5info(file, variable);
  exists = true;
catch e
  if e.identifier ~= "MATLAB:imagesci:h5info:unableToFind"
    rethrow(e)
  end
end

end
