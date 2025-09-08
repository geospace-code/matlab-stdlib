function ok = is_admin()

% com.sun.security.auth.module.NTSystem().getGroupIDs();
% Administrator group SID (S-1-5-32-544) is not an appropriate check .getGroupIDs because it
% only tells if a user is *allowed* to run as admin, not if they are currently running as admin.


try
  ok = com.sun.security.auth.module.UnixSystem().getUid() == 0;
catch e
  javaException(e)
  ok = logical.empty;
end

end
