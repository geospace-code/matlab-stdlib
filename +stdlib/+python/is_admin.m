function y = is_admin()

if isunix()
  y = py.os.getuid() == 0;
else
  shell32 = py.ctypes.WinDLL('shell32');

  % this is a key step vs. simply py.ctypes.windll.shell32.IsUserAnAdmin()
  f = py.getattr(shell32, 'IsUserAnAdmin');

  y = logical(f());
end

end
