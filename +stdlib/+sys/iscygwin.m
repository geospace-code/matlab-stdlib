function iscyg = iscygwin()
%% iscygwin()
% detects if running under Cygwin
%
% Note: primarily for GNU Octave as it's unlikely Matlab would run under Cygwin!

if ispc || ismac
  iscyg=false;
elseif isunix
  fid = fopen('/proc/version');
  v = fscanf(fid,'%s');
  fclose(fid);
  iscyg = contains(v, 'CYGWIN');
end

end
