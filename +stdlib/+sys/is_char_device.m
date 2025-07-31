function y = is_char_device(file)

cmd = sprintf('test -c %s', file);

[s, ~] = system(cmd);
y = s == 0;

end
