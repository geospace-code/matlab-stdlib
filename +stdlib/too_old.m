%% TOO_OLD check if Matlab older than R2020b or as specified by release "r"
% returns true for any version for any Matlab older than R2020b
% purpose is to avoid verLessThan lint warnings.
%
% example:
%  too_old("R2020b")
%


function old = too_old(r)

try
  old = isMATLABReleaseOlderThan(r);
catch e
  if strcmp(e.identifier, 'MATLAB:UndefinedFunction')
    old = true;
  else
    rethrow(e)
  end
end

end

%!testif 0
