require 'formula'

class Rrdtool <Formula
  url 'http://oss.oetiker.ch/rrdtool/pub/rrdtool-1.4.3.tar.gz'
  homepage 'http://oss.oetiker.ch/rrdtool/'
  md5 '492cf946c72f85987238faa2c311b7bb'

  def install
    system "./configure",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--prefix=#{prefix}",
      "--disable-perl",
      "--disable-python",
      "--disable-ruby"

    system "make install"
  end
end
