function p = join(base, other)

r = javaPathObject(base).resolve(other);
p = jPosix(r);

end
