%% ISCYGWIN  Detect if running under Cygwin

function y = iscygwin()

y = false;

if isunix && ~ismac
  fid = fopen('/proc/version');
  if fid < 0, return, end
  v = fscanf(fid,'%s');
  fclose(fid);
  y = ~isempty(strfind(v, 'CYGWIN')); %#ok<STREMP>
end

end

%!assert(islogical(iscygwin()))
