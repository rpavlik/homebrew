require 'formula'

class Libxmlxx <Formula
  url 'http://ftp.gnome.org/pub/GNOME/sources/libxml++/2.30/libxml++-2.30.1.tar.bz2'
  homepage 'http://libxmlplusplus.sourceforge.net/'
  md5 '0de2bd8c38cf308983df7d531681da56'

  # depends_on 'cmake'
  depends_on 'glibmm'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    # system "cmake . #{std_cmake_parameters}"
    system "make install"
  end
end
