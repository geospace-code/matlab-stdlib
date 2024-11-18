function r = proximate_to(base, other)
%% PROXIMATE_TO proximate path to base
arguments
  base (1,1) string
  other (1,1) string
end

r = stdlib.relative_to(base, other);
if strlength(r) > 0
  return;
end

r = other;

end
