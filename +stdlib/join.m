%% JOIN join two paths with posix file separator

function p = join(base, other)

rno = stdlib.root_name(other);
rnb = stdlib.root_name(base);
rdo = stdlib.root_dir(other);

if stdlib.is_absolute(other) || (~stdlib.strempty(rno) && ~strcmp(rnb, rno))

  p = other;

elseif ~stdlib.strempty(rdo)

  if ~stdlib.strempty(rnb)
    if endsWith(rnb, ["/", filesep])
      p = stdlib.append(rnb, other);
    else
      p = stdlib.append(rnb, '/', other);
    end
  else
    p = other;
  end

elseif ~stdlib.strempty(base)

  if ~stdlib.strempty(other)
    if endsWith(base, ["/", filesep])
      p = stdlib.append(base, other);
    else
      p = stdlib.append(base, '/', other);
    end
  else
    p = base;
  end

else

  p = other;

end

end
