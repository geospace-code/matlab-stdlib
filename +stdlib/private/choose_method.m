function fun = choose_method(method, name)
arguments
  method (1,:) string 
  name (1,1) string
end

if isscalar(method)
  % bypass checking for about 20% speed boost
  fun = str2func("stdlib." + method + "." + name);
  return
end

for m = method
  if m == "native"
    has = true;
  else
    has = str2func("stdlib.has_" + m);
  end

  if has()
    fun = str2func("stdlib." + m + "." + name);
    f = functions(fun);
    if ~isempty(f.file) || isfield(f, 'opaqueType')
      return
    end
  end
end

error("Could not find %s using %s", name, join(method, ','))

end
