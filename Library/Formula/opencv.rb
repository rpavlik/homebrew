require 'formula'

class Opencv <Formula
  url 'http://downloads.sourceforge.net/project/opencvlibrary/opencv-unix/2.1/OpenCV-2.1.0.tar.bz2'
  homepage 'http://opencv.willowgarage.com'
  md5 '1d71584fb4e04214c0085108f95e24c8'

  depends_on 'cmake'# unless system 'cmake', '--version'
  depends_on 'libpng'
  depends_on 'jasper'
  depends_on 'jpeg'
  depends_on 'libtiff'
  #depends_on 'openexr' # needed?
  depends_on 'tbb30'

  # Bug: it still builds its own libpng, jasper, tiff, etc
  def install
  	# Use the replacement libpng
  	ENV.libpng
    
    args = [ "#{std_cmake_parameters}",
#      '-DCMAKE_CXX_COMPILER="/usr/bin/g++-4.0"',
#      '-DCMAKE_C_COMPILER="/usr/bin/gcc-4.0"',
      '-DWITH_PNG=ON',
      '-DWITH_JPEG=ON',
      '-DWITH_JASPER=ON',
      '-DWITH_TIFF=ON',
      '-DWITH_TBB=ON',
      '-DOPENCV_BUILD_3RDPARTY_LIBS=OFF']
    
    # 10.5 compatibility: use Carbon and old QuickTime API
    args << "-DWITH_CARBON=ON" if MACOS_VERSION <= 10.5
    args << "-DWITH_QUICKTIME=ON" if MACOS_VERSION <= 10.5

	# build
    system "mkdir", "brew.build"
    system "cd", "brew.build"
    system "cmake", ".", *args
    system "make", "install"
  end
end
