require 'formula'

class Opencv <Formula
  url 'http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.1/OpenCV-2.1.0.tar.bz2/download'
  homepage 'http://opencv.willowgarage.com/wiki/'
  md5 '1d71584fb4e04214c0085108f95e24c8'
  head 'https://code.ros.org/svn/opencv/trunk/opencv'
  version '2.1.0'

  depends_on :subversion if MACOS_VERSION < 10.6 and ARGV.include? '--HEAD'
  def download_strategy
    if ARGV.include? '--HEAD'
      SubversionDownloadStrategy
    else
      CurlDownloadStrategy
    end
  end
  # TODO: support having it installed from the upstream package
  depends_on 'cmake'
  depends_on 'pkg-config'

  # TODO: for some reason, even with these installed, it builds its own copy.
  # This might not be bad, though - matched build parameters and static linking
  # this way.
  #depends_on 'libpng'
  #depends_on 'jasper'
  #depends_on 'jpeg'
  #depends_on 'libtiff'

  # Threading
  depends_on 'tbb'

  # Very Optional? Pulls in lots of dependencies but maybe not needed unless you're doing video analysis
  # Video analysis requires a bunch more things which we don't have: libgstreamer, libxine, unicap, libdc1394 2.x (or libdc1394 1.x + libraw1394).
  # We can leave this disabled for now.
  # Maybe we could add a flag?
  #depends_on 'ffmpeg'
  
  # There are other optional dependencies but they don't currently exist in Homebrew.


  # Bug: it still builds its own libpng, jasper, tiff, etc
  def install

# potentially useful or needed options:
#      '-DCMAKE_CXX_COMPILER="/usr/bin/g++-4.0"',
#      '-DCMAKE_C_COMPILER="/usr/bin/gcc-4.0"',
#      '-DWITH_PNG=ON',
#      '-DWITH_JPEG=ON',
#      '-DWITH_JASPER=ON',
#      '-DWITH_TIFF=ON',
#      '-DOPENCV_BUILD_3RDPARTY_LIBS=OFF']

	# configure
	if MACOS_VERSION <= 10.5
	  # Cocoa gui in 2.1.0 not functional on Leopard according to release notes
      system "cmake . #{std_cmake_parameters} -DWITH_TBB=ON -DBUILD_TESTS=OFF -DWITH_CARBON=ON -DWITH_QUICKTIME=ON"
    else
      system "cmake . #{std_cmake_parameters} -DWITH_TBB=ON -DBUILD_TESTS=OFF"
    end

#   system "cmake -G 'Unix Makefiles' -DCMAKE_INSTALL_PREFIX:PATH=#{prefix} ."

    # build
    system "make"
    system "make", "install"

  end
    def caveats
      return <<-EOS
  The OpenCV Python module will not work until you edit your PYTHONPATH like so:
  
    export PYTHONPATH="#{HOMEBREW_PREFIX}/lib/python2.6/site-packages/:$PYTHONPATH"
  
  To make this permanent, put it in your shell's profile (e.g. ~/.profile).
    EOS
  end
end
