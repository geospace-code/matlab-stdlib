function y = is_admin()

y = com.sun.security.auth.module.UnixSystem().getUid() == 0;

end
