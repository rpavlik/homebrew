require 'formula'

class Wv < Formula
  url 'http://abisource.com/downloads/wv/1.2.7/wv-1.2.7.tar.gz'
  homepage 'http://wvware.sourceforge.net/'
  sha256 'a3a367062e894770fc3ef63bbf7e285cb025253f972fa899c16931f741e856ea'

  depends_on 'glib'
  depends_on 'libgsf'
  depends_on 'libwmf'

  def install
    ENV.libxml2
    ENV.libpng
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make"
    ENV.deparallelize
    system "make install"
  end
end
