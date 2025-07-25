function ok = create_symlink(target, link)

try
  py.os.symlink(target, link);
  ok = true;
catch e
  warning(e.identifier, "create_symlink(%s, %s) failed: %s", target, link, e.message);
  ok = false;
end

end
