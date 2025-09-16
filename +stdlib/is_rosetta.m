%% IS_ROSETTA on Apple Silicon via Rosetta
%
% true if Matlab on Apple Silicon CPU is built for Intel x86_64
%%% Outputs
% * r: true if running under Rosetta
% * b: backend used
%
% "uname -m" reports "x86_64" from within Matlab on Apple Silicon if using Rosetta

function r = is_rosetta()

if ismac()
  [s, raw] = system('sysctl -n sysctl.proc_translated');
  r = s == 0 && raw(1) == '1';
else
  r = false;
end

end
