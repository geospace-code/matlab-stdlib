function ok = create_symlink(target, link)

ok = false;

try
  t = py.str(target);
  l = py.str(link);

  if ~py.os.path.exists(t) || py.os.path.exists(l)
    return
  end

  py.os.symlink(t, l);
  ok = true;
catch e
  pythonException(e)
  ok = logical.empty;
end

end
