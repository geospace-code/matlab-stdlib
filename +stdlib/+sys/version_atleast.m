function r = version_atleast(in, ref)
%% version_atleast(in, ref)
% compare two string verions: major.minor.rev.patch
%% Inputs
% * in: version to compare
% * ref: version to compare against
%% Outputs
% * r: logical
arguments
  in (1,1) string
  ref (1,1) string
end

in = split(in, " ");
in = str2double(split(in(1), "."));

ref = str2double(split(ref, "."));

r = false;

for i = 1:min(length(in), length(ref))
  if in(i) < ref(i)
    return
  end
end

r = true;

end % function
