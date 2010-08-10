require 'formula'

class Openscenegraph <Formula
  url 'http://www.openscenegraph.org/downloads/stable_releases/OpenSceneGraph-2.8.3/source/OpenSceneGraph-2.8.3.zip'
  homepage 'http://www.openscenegraph.org/'
  md5 'dc43b9161555c4eab7f5a678dd4e01ab'

  depends_on 'cmake'
  depends_on 'pcre'
  depends_on 'ffmpeg'
  depends_on 'gdal'
  depends_on 'jasper'
  depends_on 'jpeg'
  depends_on 'openexr'

  def install
    if MACOS_VERSION >= 10.6 and Hardware.is_64_bit?
      system "cmake . #{std_cmake_parameters} -DBUILD_OSG_WRAPPERS=ON -DCMAKE_OSX_ARCHITECTURES=x86_64 -DOSG_DEFAULT_IMAGE_PLUGIN_FOR_OSX=imageio -DOSG_WINDOWING_SYSTEM=Cocoa"
    else
      system "cmake . #{std_cmake_parameters} -DBUILD_OSG_WRAPPERS=ON -DCMAKE_OSX_ARCHITECTURES=i386"
    end
    system "make install"
  end

end
