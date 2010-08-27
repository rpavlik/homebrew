require 'formula'

class Flagpoll <Formula
  url 'http://flagpoll.googlecode.com/files/flagpoll-0.9.1.tar.gz'
  homepage 'http://code.google.com/p/flagpoll/'
  md5 'c4ac50ae99a880704abfc62a64ed16aa'
  def patches
    # Fix/enhance search path code to properly find flagpoll files in any prefix in
    # your PATH or DYLD_LIBRARY_PATH, as well any in the same prefix as Flagpoll
    # itself.
    DATA
  end

  def install
    system("mkdir -p #{HOMEBREW_PREFIX}/lib/flagpoll")
    system("mkdir -p #{HOMEBREW_PREFIX}/share/flagpoll")

    system "./setup.py", "install", "--prefix=#{prefix}"
  end
end

__END__
diff --git a/flagpoll b/flagpoll
old mode 100644
new mode 100755
index e31a7e1..da2635f
--- a/flagpoll
+++ b/flagpoll
@@ -226,12 +226,21 @@ class Utils:
       if os.environ.has_key("FLAGPOLL_PATH"):
          flg_cfg_dir = os.environ["FLAGPOLL_PATH"].split(os.pathsep)
 
+      prefix_dirs = ['lib64', 'lib32', 'lib', 'share']
+      exec_prefix = os.path.abspath(pj(os.path.dirname(__file__), '..'))
+      ld_path.extend([pj(exec_prefix, d, 'pkgconfig') for d in prefix_dirs])
+      ld_path.extend([pj(exec_prefix, d, 'flagpoll') for d in prefix_dirs])
+
       ld_dirs = ['LD_LIBRARY_PATH', 'DYLD_LIBRARY_PATH', 'PATH']
       for d in ld_dirs:
          if os.environ.has_key(d):
             cur_path = os.environ[d].split(os.pathsep)
             ld_path_pkg = [pj(p,'pkgconfig') for p in cur_path]
             ld_path_flg = [pj(p,'flagpoll') for p in cur_path]
+
+            for dr in prefix_dirs:
+               ld_path_pkg.extend( [os.path.normpath(pj(p,'..', dr, 'pkgconfig')) for p in cur_path] )
+               ld_path_flg.extend( [os.path.normpath(pj(p,'..', dr, 'flagpoll')) for p in cur_path] )
             ld_path.extend(ld_path_pkg)
             ld_path.extend(ld_path_flg)
 
@@ -248,9 +257,14 @@ class Utils:
 
       flagDBG().out(flagDBG.VERBOSE, "Utils.getPathList",
                     "Potential path list: " + str(path_list))
-      path_list = [p for p in path_list if os.path.exists(p)]
+      clean_path_list = []
+      for p in path_list:
+         if os.path.exists(p) and os.path.isdir(p) and not p in clean_path_list:
+            clean_path_list.append(p)
+      path_list = clean_path_list
       flagDBG().out(flagDBG.INFO, "Utils.getPathList",
                     "Using path list: " + str(path_list))
+
       Utils.path_list_cache = path_list
       return path_list
    getPathList = staticmethod(getPathList)
