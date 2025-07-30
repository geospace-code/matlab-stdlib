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
    case "dotnet"
      has = @stdlib.has_dotnet;

      if endsWith(name, "ram_total")
        if stdlib.dotnet_api() < 6, continue, end
      end
    case "python"
      has = @stdlib.has_python;

      if endsWith(name, ["filesystem_type", "ram_total", "ram_free"])
        if ~stdlib.python.has_psutil(); continue, end
      end
    case {"legacy", "sys"}, has = true;
    case "native", has = stdlib.strempty(minVersion) || ~isMATLABReleaseOlderThan(minVersion);
    case "sys"
      has = true;
    otherwise
      has = str2func("stdlib.has_" + m);
  end

  if has()
    n = "stdlib." + m + "." + name;
    fun = str2func(n);
    % don't use functions() it's not for programmatic use and its behavior
    % changed in R2025a
    fp = which(n);
    if ~isempty(fp)
      return
    end
  end
end

error("stdlib:choose_method:NameError", "Could not find any %s capable of running, using %s", name, join(method, ','))

end
