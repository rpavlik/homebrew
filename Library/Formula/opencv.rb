require 'formula'

class Opencv <Formula
  url 'http://downloads.sourceforge.net/project/opencvlibrary/opencv-unix/2.1/OpenCV-2.1.0.tar.bz2'
  homepage 'http://opencv.willowgarage.com'
  md5 '1d71584fb4e04214c0085108f95e24c8'

  # TODO: support having it installed from the upstream package
  depends_on 'cmake'

  # TODO: for some reason, even with these installed, it builds its own copy.
  # This might not be bad, though - matched build parameters and static linking
  # this way.
  #depends_on 'libpng'
  #depends_on 'jasper'
  #depends_on 'jpeg'
  #depends_on 'libtiff'

  # Threading
  depends_on 'tbb30'

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

    # build
    system "make"
    system "make", "install"
  end
end
