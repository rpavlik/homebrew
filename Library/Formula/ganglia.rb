require 'formula'

class Ganglia <Formula
  url 'http://downloads.sourceforge.net/project/ganglia/ganglia%20monitoring%20core/3.1.7/ganglia-3.1.7.tar.gz'
  homepage 'http://ganglia.sourceforge.net/'
  md5 '6aa5e2109c2cc8007a6def0799cf1b4c'

  # TODO: gmetad (requries rrdtool) does not build right now

  depends_on 'confuse'
  depends_on 'pcre'
  #depends_on 'rrdtool'

  def patches
    # fixes build on Leopard and newer, which lack kvm.h and its corresponding /dev/ node
    # Patch sent upstream: http://bugzilla.ganglia.info/cgi-bin/bugzilla/show_bug.cgi?id=258
    DATA
  end

  def install
    # ENV var needed to confirm putting the config in the prefix until 3.2
    ENV['GANGLIA_ACK_SYSCONFDIR'] = '1'

    # configure
    system "./configure",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--prefix=#{prefix}",
      "--sbindir=#{prefix}/bin", # brew doesn't do things with prefix/sbin
      "--with-gexec"
    #"--with-gmetad"

    # build and install
    system "make install"
  end
end

__END__
diff --git a/libmetrics/config.h.in b/libmetrics/config.h.in
index 1ff64b1..13087c6 100644
--- a/libmetrics/config.h.in
+++ b/libmetrics/config.h.in
@@ -152,6 +152,9 @@
 /* Define to 1 if you have the <sys/fs/s5param.h> header file. */
 #undef HAVE_SYS_FS_S5PARAM_H
 
+/* Define to 1 if you have the <kvm.h> header file. */
+#undef HAVE_KVM_H
+
 /* Define to 1 if you have the <sys/mount.h> header file. */
 #undef HAVE_SYS_MOUNT_H
 
diff --git a/libmetrics/configure.in b/libmetrics/configure.in
index 213d162..b5aa98e 100644
--- a/libmetrics/configure.in
+++ b/libmetrics/configure.in
@@ -31,7 +31,7 @@ AC_HAVE_LIBRARY(nsl)
 # Checks for header files.
 AC_HEADER_DIRENT
 AC_HEADER_STDC
-AC_CHECK_HEADERS([fcntl.h inttypes.h limits.h nlist.h paths.h stdlib.h strings.h sys/filsys.h sys/fs/s5param.h sys/mount.h sys/param.h sys/socket.h sys/statfs.h sys/statvfs.h sys/systeminfo.h sys/time.h sys/vfs.h unistd.h utmp.h sys/sockio.h])
+AC_CHECK_HEADERS([fcntl.h inttypes.h limits.h nlist.h paths.h stdlib.h strings.h sys/filsys.h sys/fs/s5param.h sys/mount.h sys/param.h sys/socket.h sys/statfs.h sys/statvfs.h sys/systeminfo.h sys/time.h sys/vfs.h unistd.h utmp.h sys/sockio.h kvm.h])
 AC_CHECK_HEADERS([rpc/rpc.h],, 
    [AC_MSG_ERROR([your system is missing the Sun RPC (ONC/RPC) libraries])])
 
diff --git a/libmetrics/darwin/metrics.c b/libmetrics/darwin/metrics.c
index 498ed8f..bfa09a1 100644
--- a/libmetrics/darwin/metrics.c
+++ b/libmetrics/darwin/metrics.c
@@ -9,9 +9,17 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <stdlib.h>
 #include "interface.h"
+
+#if defined(HAVE_LIBKVM) && defined(HAVE_KVM_H)
 #include <kvm.h>
+#endif
+
 #include <sys/sysctl.h>
 
 #include <mach/mach_init.h>

