require 'formula'

class Cppcheck < Formula
  url 'http://downloads.sourceforge.net/project/cppcheck/cppcheck/1.43/cppcheck-1.43.tar.bz2'
  homepage 'http://sourceforge.net/apps/mediawiki/cppcheck/index.php?title=Main_Page'
  md5 '303792836a890be1cda84d13efaf7e9b'
  head 'git://github.com/danmar/cppcheck.git'

  def install
    ENV.deparallelize
    ENV.no_optimization
    # Need to remove "-Wlogical-op" from c++ flags.
    cxxflags = "-Wall -Wextra -Wfloat-equal -Wcast-qual -O2 -DNDEBUG"

    # Pass to make variables.
    system "make", "BIN=#{bin}"
    system "make", "BIN=#{bin}", "install"
    # Man pages aren't installed, they require docbook schemas which I don't know how to install.
  end
end
