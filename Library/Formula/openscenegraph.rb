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
  #depends_on 'collada' => :optional

  def install
  	args = ["..", "-DCMAKE_INSTALL_PREFIX='#{prefix}'", "-DCMAKE_BUILD_TYPE=None", "-Wno-dev", "-DBUILD_OSG_WRAPPERS=ON", "-DBUILD_DOCUMENTATION=ON"]
  	if snow_leopard_64?
  		args << "-DCMAKE_OSX_ARCHITECTURES=x86_64"
  		args << "-DOSG_DEFAULT_IMAGE_PLUGIN_FOR_OSX=imageio"
  		args << "-DOSG_WINDOWING_SYSTEM=Cocoa"
  	else
  		args << "-DCMAKE_OSX_ARCHITECTURES=i386"
  	end

  	if Formula.factory('collada').installed?
  		args << "-DCOLLADA_BOOST_FILESYSTEM_LIBRARY=#{HOMEBREW_PREFIX}/lib/libboost_filesystem-mt.dylib"
  		args << "-DCOLLADA_BOOST_SYSTEM_LIBRARY=#{HOMEBREW_PREFIX}/lib/libboost_system-mt.dylib"
  		args << "-DCOLLADA_INCLUDE_DIR=#{HOMEBREW_PREFIX}/include"
  		args << "-DCOLLADA_DYNAMIC_LIBRARY=#{HOMEBREW_PREFIX}/lib/Collada14Dom.dylib"
  		args << "-DCOLLADA_PCRECPP_LIBRARY=#{HOMEBREW_PREFIX}/lib/libpcrecpp.dylib"
  		args << "-DCOLLADA_PCRE_LIBRARY=#{HOMEBREW_PREFIX}/lib/libpcre.dylib"
  	end

    Dir.mkdir "build"
    Dir.chdir "build" do
	  system "cmake", *args
	  system "make install"
	end
  end

end
