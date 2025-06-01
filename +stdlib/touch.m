%% TOUCH create file if not exists, else update modification time

function ok = touch(p, t)
arguments
  p {mustBeTextScalar}
  t datetime {mustBeScalarOrEmpty} = datetime.empty
end

ok = false;

if ~stdlib.exists(p)
  fid = fopen(p, "w");
  ok = fid > 0 && fclose(fid) == 0;
  if isempty(t)
    return
  end
end

if isempty(t)
  t = datetime("now");
end

try
  ok = stdlib.set_modtime(p, t);
catch e
  if ~strcmp(e.identifier, "MATLAB:undefinedVarOrClass")
    rethrow(e)
  end
end

end

%!test
%! f = tempname();
%! assert (touch(f, []))
%! assert (isfile(f))
