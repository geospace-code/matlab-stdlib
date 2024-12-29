%% IS_ROSETTA is running on Apple Silicon using Rosetta
% this would be true if Matlab is build for Intel x86_64

function r = is_rosetta()
r = false;

if ~ismac
  return
end

% uname -m reports "x86_64" from within Matlab on Apple Silicon if using Rosetta

[ret, raw] = system("sysctl -n sysctl.proc_translated");
r = ret == 0 && startsWith(raw, '1');

end

%!assert(islogical(is_rosetta()))
%!test
%! if ~ismac
%!  assert(!is_rosetta())
%! endif
