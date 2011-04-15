require 'formula'

class Vrpn < Formula
  url 'git://git.cs.unc.edu/vrpn.git', :tag => 'version_07.28'
  head 'git://github.com/rpavlik/vrpn.git'
  version '07.28'
  homepage 'http://vrpn.org'

  depends_on 'libusb' # for HID support
  depends_on 'cmake' => :build
  depends_on 'doxygen' if ARGV.include? '--docs'

  def options
    [
      ['--clients', 'Build client apps and tests.'],
      ['--docs', 'Build doxygen-based API documentation']
    ]
  end

  def install
    args = std_cmake_parameters.split

    if ARGV.include? '--clients'
      args << "-DVRPN_BUILD_CLIENTS:BOOL=ON"
    else
      args << "-DVRPN_BUILD_CLIENTS:BOOL=OFF"
    end
    args << ".."

    Dir.mkdir "build"
    Dir.chdir "build" do
      system "cmake", *args

      if ARGV.include? '--docs'
        system "make doc"
      end

      system "make install"
    end
  end
end
