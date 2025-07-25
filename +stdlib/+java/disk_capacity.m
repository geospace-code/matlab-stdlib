function f = disk_capacity(d)

f = uint64(javaObject("java.io.File", d).getTotalSpace());

end
