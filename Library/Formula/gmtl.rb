require 'formula'

class Gmtl <Formula
  url 'http://downloads.sourceforge.net/project/ggt/Generic%20Math%20Template%20Library/0.6.0/gmtl-0.6.0.tar.gz'
  homepage ''
  md5 ''

 depends_on 'scons'

  def install
    system "scons", "install", "prefix=#{prefix}"
  end
end
