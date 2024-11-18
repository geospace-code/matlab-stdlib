function iscyg = iscygwin()
%% ISCYGWIN  Detect if running under Cygwin

if ispc || ismac
  iscyg = false;
elseif isunix
  fid = fopen('/proc/version');
  v = fscanf(fid,'%s');
  fclose(fid);
  iscyg = contains(v, 'CYGWIN');
end

end
