%% JOIN join two paths with posix file separator

function p = join(base, other)
arguments
  base {mustBeTextScalar}
  other {mustBeTextScalar}
end

rno = stdlib.root_name(other);
rnb = stdlib.root_name(base);
rdo = stdlib.root_dir(other);

if stdlib.is_absolute(other) || (~stdlib.strempty(rno) && ~strcmp(rnb, rno))

  p = other;

elseif ~stdlib.strempty(rdo)

  if ~stdlib.strempty(rnb)
    p = fullfile(rnb, other);
  else
    p = other;
  end

elseif ~stdlib.strempty(base)

  if ~stdlib.strempty(other)
    p = fullfile(base, other);
  else
    p = base;
  end

else

  p = other;

end

end
