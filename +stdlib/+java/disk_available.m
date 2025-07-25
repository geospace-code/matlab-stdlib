function f = disk_available(d)

f = uint64(javaObject("java.io.File", d).getUsableSpace());

end
