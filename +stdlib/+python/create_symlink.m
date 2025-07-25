function ok = create_symlink(target, link)

ok = false;

if ~stdlib.exists(target) || strlength(link) == 0 || stdlib.exists(link)
  return
end

try
  py.os.symlink(target, link);
  ok = true;
catch e
  warning(e.identifier, "create_symlink(%s, %s) failed: %s", target, link, e.message);
  ok = false;
end

end
