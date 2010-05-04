require 'formula'

class Cppcheck <Formula
  head 'git://github.com/danmar/cppcheck.git'
  homepage 'http://cppcheck.wiki.sourceforge.net'
  url 'http://downloads.sourceforge.net/project/cppcheck/cppcheck/1.42/cppcheck-1.42.tar.bz2'
  md5 '20c495b191a9f4fdd030656ad9d4741d'

  def install
    system "make", "install", "BIN=#{bin}"
  end
end
