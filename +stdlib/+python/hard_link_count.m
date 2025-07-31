function c = hard_link_count(p)

try
  c = double(py.os.stat(p).st_nlink);
catch e
  warning(e.identifier, "hard_link_count(%s) failed: %s", p, e.message);
  c = 0;
end

end
