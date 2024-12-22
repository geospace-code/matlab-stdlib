%% MAKEDIR make dtory and check for success
% malformed paths can be "created" but are not accessible.
% This function works around that bug in Matlab mkdir().

function makedir(d)
arguments
  d (1,1) string {mustBeNonzeroLengthText}
end

%% to avoid confusing making ./~/mydir
d = stdlib.expanduser(d);

if isfolder(d)
  return
end

mkdir(d);

assert(isfolder(d), "stdlib:makedir:mkdir", "Failed to create %s", d)

end

%!test
%! d = tempname();
%! makedir(d);
