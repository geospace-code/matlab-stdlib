function n = normalize(p)

% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Path.html#normalize()
o = javaPathObject(p).normalize();
n = stdlib.drop_slash(jPosix(o));

end
