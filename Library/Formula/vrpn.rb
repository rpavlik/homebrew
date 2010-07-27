require 'formula'

class Vrpn <Formula
  #url 
  head 'git://github.com/rpavlik/vrpn.git'
  #version '07.26.2'
  homepage 'http://vrpn.org'

  depends_on 'cmake'

  def install
    system "mkdir build"
    Dir.chdir "build"
    system "cmake .. #{std_cmake_parameters}"
    system "make install"
  end
end
