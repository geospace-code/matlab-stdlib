function ok = create_symlink(target, link)

t = py.str(target);
l = py.str(link);

if ~py.os.path.exists(t) || py.os.path.exists(l)
  ok = false;
  return
end

py.os.symlink(t, l);
ok = true;

end
