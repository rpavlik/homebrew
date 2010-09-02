require 'formula'

class Collada <Formula
  url 'http://cdnetworks-us-2.dl.sourceforge.net/project/collada-dom/Collada%20DOM/Collada%20DOM%202.2/Collada%20DOM%202.2.zip'
  homepage 'http://www.collada.org/mediawiki/index.php/Portal:COLLADA_DOM'
  version '2.2'
  md5 '3f7e4fc2372d80d0f8c0732da0e41c1a'

  depends_on 'pcre'
  depends_on 'boost'

  def install
    Dir.chdir("dom")
    if snow_leopard_64?
    	arg = "archs=x86_64"
    else
    	arg = "archs=i386"
    end
    system "make", arg
    include.install "include/*"
    lib.install "build/mac-1.4/Collada14Dom.dylib"
  end
  
  def patches
  	# Allow building a 64-bit binary
  	return DATA
  end
end

__END__
diff --git a/dom/Makefile b/dom/Makefile
index ae8ff60..e740bab 100644
--- a/dom/Makefile
+++ b/dom/Makefile
@@ -87,8 +87,8 @@ ifneq ($(filter-out linux mac ps3 windows,$(oss)),)
 $(error Invalid setting os=$(os))
 endif
 
-archs := $(sort $(subst i386,x86,$(arch)))
-ifneq ($(filter-out x86 ppc,$(archs)),)
+archs := $(sort $(arch))
+ifneq ($(filter-out x86 x86_64 ppc,$(archs)),)
 $(error Invalid setting arch=$(arch))
 endif
 
diff --git a/dom/make/common.mk b/dom/make/common.mk
index 4199452..02dcbfe 100644
--- a/dom/make/common.mk
+++ b/dom/make/common.mk
@@ -19,7 +19,7 @@ endif
 
 ifeq ($(os),mac)
 # Add the -arch flags to specify what architectures we're building for.
-ccFlags += $(addprefix -arch ,$(subst x86,i386,$(archs)))
+ccFlags += $(addprefix -arch ,$(archs))
 endif
 
 libOpts :=

diff --git a/dom/make/dom.mk b/dom/make/dom.mk
index 8a3d672..45d454f 100644
--- a/dom/make/dom.mk
+++ b/dom/make/dom.mk
@@ -42,8 +42,8 @@ else
 ifeq ($(os),windows)
 ccFlags += -DPCRE_STATIC
 endif
-includeOpts += -Iexternal-libs/pcre
-libOpts += $(addprefix external-libs/pcre/lib/$(buildID)/,libpcrecpp.a libpcre.a )
+#includeOpts += -Iexternal-libs/pcre
+libOpts += -lpcre -lpcrecpp
 endif
 
 # For mingw: add boost
@@ -52,9 +52,9 @@ includeOpts += -Iexternal-libs/boost
 libOpts += external-libs/boost/lib/$(buildID)/libboost_system.a
 libOpts += external-libs/boost/lib/$(buildID)/libboost_filesystem.a
 else ifeq ($(os),mac)
-includeOpts += -Iexternal-libs/boost
-libOpts += external-libs/boost/lib/$(buildID)/libboost_system.a
-libOpts += external-libs/boost/lib/$(buildID)/libboost_filesystem.a
+#includeOpts += -Iexternal-libs/boost
+libOpts += -lboost_system-mt
+libOpts += -lboost_filesystem-mt
 endif
 
 # minizip
diff --git a/dom/make/domTest.mk b/dom/make/domTest.mk
index 33b37cf..d22e580 100644
--- a/dom/make/domTest.mk
+++ b/dom/make/domTest.mk
@@ -58,9 +58,9 @@ endif
 ifeq ($(os),linux)
 libOpts += -lboost_filesystem
 else
-includeOpts += -Iexternal-libs/boost
-libOpts += external-libs/boost/lib/$(buildID)/libboost_system.a
-libOpts += external-libs/boost/lib/$(buildID)/libboost_filesystem.a
+#includeOpts += -Iexternal-libs/boost
+libOpts += -lboost_system-mt
+libOpts += -lboost_filesystem-mt
 endif
 ifeq ($(os),ps3)
 # PS3 doesn't support C++ locales, so tell boost not to use them
