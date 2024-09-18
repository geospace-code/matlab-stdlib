function r = version_atleast(in, ref)
% compare two string verions: major.minor.rev.patch
% uses strings to compare so mixed number/string is OK
%
% parameters
% ------------
% in: version to examine (string)
% ref: version to compare against (at least this version is true)
%
% returns
% -------
% r: logical

arguments
  in (1,1) string
  ref (1,1) string
end

in = split(in, ' ');
in = split(in(1), '.');

ref = split(ref, '.');

for i = 1:min(length(in), length(ref))
  if in(i) > ref(i)
    r = true;
    return
  elseif in(i) < ref(i)
    r = false;
    return
  end
end

r = in(end) >= ref(end);

end % function
