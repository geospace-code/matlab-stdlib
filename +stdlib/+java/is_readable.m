function y = is_readable(p)

y = javaObject("java.io.File", p).canRead();

end
