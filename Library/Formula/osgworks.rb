require 'formula'

class Osgworks <Formula
  head 'http://osgworks.googlecode.com/svn/branches/1_01-branch', :using => :svn
  homepage 'http://code.google.com/p/osgworks'
  version '1.1'

  depends_on 'cmake'
  depends_on 'openscenegraph'

  def install
    system "cmake . #{std_cmake_parameters}"
    system "make install"
  end
end
