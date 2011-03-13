require 'formula'

class Gmtl < Formula
  url 'http://downloads.sourceforge.net/project/ggt/Generic%20Math%20Template%20Library/0.6.1/gmtl-0.6.1.tar.gz'
  md5 '1391af2c5ea050dda7735855ea5bb4c1'
  head 'https://ggt.svn.sourceforge.net/svnroot/ggt/trunk/'
  homepage 'http://ggt.sourceforge.net/'

  depends_on 'scons' => :build
  def patches
    # build assumes that Python to be used is in a framework, which isn't always true
	# https://sourceforge.net/tracker/?func=detail&aid=3172856&group_id=43735&atid=437247
    "https://gist.github.com/raw/811405/fix-gmtl-build.diff"
  end

  def install
    system "scons", "install", "prefix=#{prefix}"
  end
end
