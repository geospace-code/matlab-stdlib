function fun = choose_method(method, name, minVersion)
arguments
  method (1,:) string 
  name (1,1) string
  minVersion {mustBeTextScalar} = ''
end

if isscalar(method)
  % bypass checking for about 20% speed boost
  fun = str2func("stdlib." + method + "." + name);
  return
end

for m = method
  switch m
    case "legacy", has = true;
    case "native", has = stdlib.strempty(minVersion) || ~isMATLABReleaseOlderThan(minVersion);
    otherwise, has = str2func("stdlib.has_" + m);
  end

  if has()
    fun = str2func("stdlib." + m + "." + name);
    f = functions(fun);
    if ~isempty(f.file) || isfield(f, 'opaqueType')
      return
    end
  end
end

error("Could not find any %s capable of running, using %s", name, join(method, ','))

end
