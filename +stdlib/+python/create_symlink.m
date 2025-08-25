function ok = create_symlink(target, link)

ok = false;

t = py.str(target);
l = py.str(link);

if ~py.os.path.exists(t) || py.os.path.exists(l)
  return
end

try
  py.os.symlink(t, l);
  ok = true;
catch e
  warning(e.identifier, "create_symlink(%s, %s) failed: %s", target, link, e.message);
  ok = false;
end

end
