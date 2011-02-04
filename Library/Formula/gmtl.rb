require 'formula'

class Gmtl <Formula
  url 'http://downloads.sourceforge.net/project/ggt/Generic%20Math%20Template%20Library/0.6.0/gmtl-0.6.0.tar.gz'
  head 'https://ggt.svn.sourceforge.net/svnroot/ggt/trunk/'
  homepage 'http://ggt.sourceforge.net/'
  md5 '018c2cce3c87ad63509481b1eb144387'

  depends_on 'scons' => :build
  def patches
    # build assumes that Python to be used is in a framework, which isn't always true
    "https://gist.github.com/raw/811405/fix-gmtl-build.diff"
  end

  def install
    system "scons", "install", "prefix=#{prefix}"
  end
end
