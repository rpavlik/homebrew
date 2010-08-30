require 'formula'

class Abiword <Formula
  url 'http://abisource.com/downloads/abiword/2.8.6/source/abiword-2.8.6.tar.gz'
  homepage 'http://abisource.com'
  sha1 '998f69d038000b3fc027d4259548f02d67c8d0df'

  # WORK IN PROGRESS

  depends_on 'enchant'
  depends_on 'libgsf'
  depends_on 'pango'
  depends_on 'cairo'
  depends_on 'fribidi'
  depends_on 'libwpd' => :recommended
  depends_on 'imagemagick'
#  depends_on 'libwpg'
#  depends_on 'libwmf'


  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--enable-plugins", "--enable-templates", "--prefix=#{prefix}"
    # system "cmake . #{std_cmake_parameters}"
    system "make install"
  end
end
