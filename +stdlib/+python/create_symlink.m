function ok = create_symlink(target, link)
arguments
  target (1,1) string
  link (1,1) string
end

ok = false;

if ~stdlib.exists(target) || stdlib.strempty(link) || stdlib.exists(link)
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
