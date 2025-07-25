%% IS_CYGWIN  Detect if running under Cygwin

function y = is_cygwin()

y = false;

if isunix() && ~ismac()
  fid = fopen('/proc/version');
  if fid > 0
    v = fscanf(fid,'%s');
    fclose(fid);
    y = ~isempty(strfind(v, 'CYGWIN')); %#ok<STREMP>
  end
end

end
