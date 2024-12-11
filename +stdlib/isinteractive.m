%% ISINTERACTIVE tell if being run interactively
%
% NOTE: don't use batchStartupOptionUsed as it neglects the "-nodesktop" case

function g = isinteractive()

if stdlib.isoctave()
  g = ~isempty(graphics_toolkit());
else
  g = usejava('desktop');
end

end

%!assert (islogical(isinteractive()))
