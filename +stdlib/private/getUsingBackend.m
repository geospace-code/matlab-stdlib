function [i, b] = getUsingBackend(backend, funcName, args)
arguments
  backend (1,:) string
  funcName {mustBeTextScalar,mustBeNonzeroLengthText}
end
arguments (Repeating)
  args
end

i = missing;

pkgName = "stdlib";

for b = filterBackend(backend, funcName)
  f = str2func(join([pkgName, b, funcName], "."));
  i = f(args{:});

  if ~ismissing(i)
    return
  end
end

end
