require 'formula'

class Bullet <Formula
  head 'http://bullet.googlecode.com/svn/tags/bullet-2.75', :using => :svn
  homepage 'http://bullet.googlecode.com'
  md5 ''
  version '2.75'

  depends_on 'cmake'

  def install
    system "cmake . #{std_cmake_parameters} -DBUILD_DEMOS=OFF"
    system "make install"
  end
end
