require 'formula'

class Osgbullet <Formula
  head 'http://osgbullet.googlecode.com/svn/branches/1_01-branch'
  homepage 'http://code.google.com/p/osgbullet/'


  depends_on 'cmake'
  depends_on 'openscenegraph'
  depends_on 'osgworks'

  def install
    system "cmake . #{std_cmake_parameters}"
    system "make install"
  end
end
