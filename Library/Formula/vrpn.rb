require 'formula'

class Vrpn <Formula
  url 'git://git.cs.unc.edu/vrpn.git', :tag => 'version_07.28'
  head 'git://github.com/rpavlik/vrpn.git'
  version '07.28'
  homepage 'http://vrpn.org'

  depends_on 'cmake' => :build

  def options
    [['--clients', 'Build client apps and tests.']]
  end

  def install
    Dir.mkdir "build"
    Dir.chdir "build" do
      args = [ "-DCMAKE_BUILD_TYPE=Release",
        "-DCMAKE_INSTALL_PREFIX='#{prefix}'",
        "-DBUILD_TESTING=OFF" ]

      if ARGV.include? '--clients'
        args << "-DVRPN_BUILD_CLIENTS:BOOL=ON"
      else
        args << "-DVRPN_BUILD_CLIENTS:BOOL=OFF"
      end
      args << ".."

      system "cmake", *args
      system "make install"
    end
  end
end
