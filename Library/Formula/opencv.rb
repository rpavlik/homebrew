require 'formula'

class Opencv <Formula
  # Don't use stable 2.1.0 due to a massive memory leak:
  # https://code.ros.org/trac/opencv/ticket/253
  url 'https://code.ros.org/svn/opencv/trunk/opencv', :using => :svn, :revision => '3478'
  version "2.1.1-pre"
  homepage 'http://opencv.willowgarage.com/wiki/'

  # NOTE: Head builds past the revision above may break on OS X
  head 'https://code.ros.org/svn/opencv/trunk/opencv', :using => :svn

  depends_on 'cmake' => :build
  depends_on 'pkg-config' => :build

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

  def options
    [['--build32', 'Force a 32-bit build.']]
  end


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
      system "cmake .  -G 'Unix Makefiles' -DCMAKE_INSTALL_PREFIX:PATH=#{prefix} -DWITH_TBB=ON -DBUILD_TESTS=OFF -DWITH_CARBON=ON -DWITH_QUICKTIME=ON"
    else
      config = "cmake .  -G 'Unix Makefiles' -DCMAKE_INSTALL_PREFIX:PATH=#{prefix} -DWITH_TBB=ON -DBUILD_TESTS=OFF"
      config += " -DOPENCV_EXTRA_C_FLAGS='-arch i386 -m32'" if ARGV.include? '--build32'
      system config
    end

#   system "cmake -G 'Unix Makefiles' -DCMAKE_INSTALL_PREFIX:PATH=#{prefix} ."

    # build
    system "make"
    system "make", "install"

  end

  def caveats; <<-EOS.undent
    The OpenCV Python module will not work until you edit your PYTHONPATH like so:
      export PYTHONPATH="#{HOMEBREW_PREFIX}/lib/python2.6/site-packages/:$PYTHONPATH"

    To make this permanent, put it in your shell's profile (e.g. ~/.profile).
    EOS
  end
end
